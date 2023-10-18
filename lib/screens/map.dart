import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final List<List<double>> locationData;

  const MapPage({Key? key, required this.locationData}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late String _mapStyleAndroid;
  late String _mapStyleIos;

  Set<Marker> markerList = {};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final Location _locationController = Location();
  LatLng? _currentPos;

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
    getLocationUpdates();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    Platform.isAndroid
        ? controller.setMapStyle(_mapStyleAndroid)
        : controller.setMapStyle(_mapStyleIos);

    generateMarkers(widget.locationData);
  }

  void generateMarkers(List<List<double>> latLongList) async {
    for (int i = 0; i < latLongList.length; i++) {
      double hue = pow(i, 5) % 255; // Random marker colour based on post index
      BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(hue);

      markerList.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(latLongList[i][0], latLongList[i][1]),
        icon: markerIcon,
        alpha: 0.75,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: _currentPos == null
            ? const Center(child: Text("Loading..."))
            : GoogleMap(
                onMapCreated: _onMapCreated,
                rotateGesturesEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: _currentPos!,
                  zoom: 13,
                ),
                gestureRecognizers: {
                  Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer()),
                },
                markers: markerList,
              ));
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
        if (mounted) {
          setState(() {
            _currentPos =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
        }
      }
    });
  }
}
