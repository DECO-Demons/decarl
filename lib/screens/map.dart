import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final List<List<double>> locationData; // List of parsed lat/long pairs

  const MapPage({Key? key, required this.locationData}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Styles for GMaps component
  late String _mapStyleAndroid;
  late String _mapStyleIos;

  // List of Marker components to be rendered
  Set<Marker> markerList = {};

  // Controller for GMaps component
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Controller for Location component
  final Location _locationController = Location();
  LatLng? _currentPos; // User's current location

  /* void initState()
    Callback function for when the widget is created
  */
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
    getLocationUpdates(); // Get user's current location
  }

  /* _onMapCreated(GoogleMapController controller)
    Callback function for when the GoogleMap component is created

    Args:
      controller (GoogleMapController): Controller for the GoogleMap component
  */
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    Platform.isAndroid // Set map style based on platform
        ? controller.setMapStyle(_mapStyleAndroid)
        : controller.setMapStyle(_mapStyleIos);

    generateMarkers(widget.locationData); // Generate markers from data
  }

  /* void generateMarkers(List<List<double>> latLongList)
    Generates a list of Marker components from a list of lat/long pairs 

    Args:
      latLongList (List<List<double>>): List of lat/long pairs
  */
  void generateMarkers(List<List<double>> latLongList) async {
    for (int i = 0; i < latLongList.length; i++) {
      double hue = (i * 73) % 255; // Generate hue based on post index
      BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(hue);

      markerList.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(latLongList[i][0], latLongList[i][1]),
        icon: markerIcon,
        alpha: 0.75,
      ));
    }
  }

  /* Widget build(BuildContext context)
    Builds the MapPage widget

    Args:
      context (BuildContext): Context of the widget

    Returns:
      Container: Container containing the GoogleMap component
  */
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

  /* Future<void> getLocationUpdates()
    Gets user's current location and updates _currentPos
  */
  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    // Check if location permissions are granted
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
          // If widget is currently rendered, update _currentPos
          setState(() {
            _currentPos =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
        }
      }
    });
  }
}
