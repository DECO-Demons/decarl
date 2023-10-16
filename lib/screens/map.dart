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

  double zoomLevel = 13.0;
  Set<Circle> circles = {};

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
    circles = generateCircles(widget.locationData);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    Platform.isAndroid
        ? controller.setMapStyle(_mapStyleAndroid)
        : controller.setMapStyle(_mapStyleIos);
  }

  Set<Circle> generateCircles(List<List<double>> latLongList) {
    Set<Circle> circleList = {};
    double radius = 0.0 + pow(5, 1 / (zoomLevel / 50));

    for (int i = 0; i < latLongList.length; i++) {
      circleList.add(
        Circle(
            circleId: CircleId(i.toString()),
            center: LatLng(latLongList[i][0], latLongList[i][1]),
            radius: radius,
            fillColor: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            strokeColor: const Color.fromARGB(0, 0, 0, 0).withOpacity(0)),
      );
    }

    print(circleList);

    return circleList;
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
                onCameraMove: (CameraPosition position) {
                  zoomLevel = position.zoom;
                  circles = generateCircles(widget.locationData);
                },
                initialCameraPosition: CameraPosition(
                  target: _currentPos!,
                  zoom: 13,
                ),
                gestureRecognizers: {
                  Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer()),
                },
                circles: circles,
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
