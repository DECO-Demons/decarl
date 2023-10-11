import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late String _mapStyleAndroid;
  late String _mapStyleIos;

  late LatLng _center;

  //Position? _currentPosition;

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

    _determinePosition().then((value) {
      _center = LatLng(value.latitude, value.longitude);
    });
  }

  late GoogleMapController mapController;
  // Default location
  //final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    Platform.isAndroid
        ? controller.setMapStyle(_mapStyleAndroid)
        : controller.setMapStyle(_mapStyleIos);
  }

  /*void _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });

    print(_currentPosition.toString());
  }*/

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GoogleMap(
          onMapCreated: _onMapCreated,
          rotateGesturesEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          gestureRecognizers: {
            Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
          },
          circles: {
            Circle(
                circleId: CircleId("1"),
                center: _center,
                radius: 4300,
                fillColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
                strokeColor: Color.fromARGB(0, 0, 0, 0).withOpacity(0)),
          }),
    );
  }
}
