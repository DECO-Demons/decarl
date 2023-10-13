import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late String _mapStyleAndroid;
  late String _mapStyleIos;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Location _locationController = new Location();
  LatLng? _currentPos = null;

  @override
  void initState() {
    // Map style for Android must load from .txt, for iOS from .json
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyleAndroid = string;
    });
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyleIos = string;
    });

    super.initState();
    if (mounted) {
      getLocationUpdates();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    Platform.isAndroid
        ? controller.setMapStyle(_mapStyleAndroid)
        : controller.setMapStyle(_mapStyleIos);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: _currentPos == null
          ? const Center(
              child: Text(
                  "Location services not enabled, please enable them in Settings to use this feature"))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              rotateGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _currentPos!,
                zoom: 11.0,
              ),
              gestureRecognizers: {
                  Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                },
              circles: {
                  Circle(
                      circleId: CircleId("1"),
                      center:
                          LatLng(_currentPos!.latitude, _currentPos!.longitude),
                      radius: 430,
                      fillColor:
                          const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
                      strokeColor:
                          const Color.fromARGB(0, 0, 0, 0).withOpacity(0)),
                }),
    );
  }

  Future<void> _cameraToLocation(LatLng location) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPos = CameraPosition(target: location, zoom: 11.0);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPos));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPos =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToLocation(_currentPos!);
        });
      }
    });
  }
}
