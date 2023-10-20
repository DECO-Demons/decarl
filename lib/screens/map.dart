import 'dart:async';
import 'dart:math';

import 'package:decarl/components/appcolors.dart';
import 'package:decarl/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final List<List<double>> initialLocationData; // List of parsed lat/long pairs
  final Function getRefreshedAnchors;

  const MapPage(
      {Key? key,
      required this.initialLocationData,
      required this.getRefreshedAnchors})
      : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Styles for GMaps component
  late String _mapStyle;

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
    // Map style from https://mapstyle.withgoogle.com/
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
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

    controller.setMapStyle(_mapStyle);

    generateMarkers(widget.initialLocationData); // Generate markers from data
  }

  /* double distance(LatLng point1, LatLng point2)
    Calculates the distance between two lat/long pairs

    Args:
      point1 (LatLng): First lat/long pair
      point2 (LatLng): Second lat/long pair

    Returns:
      double: Distance between the two lat/long pairs
  */
  double distance(LatLng? currentPos, LatLng point2) {
    const int r = 6371; // km
    const double p = pi / 180;

    double a = 0.5 -
        cos((point2.latitude - currentPos!.latitude) * p) / 2 +
        cos(currentPos.latitude * p) *
            cos(point2.latitude * p) *
            (1 - cos((point2.longitude - currentPos.longitude) * p)) /
            2;

    return 2 * r * asin(sqrt(a));
  }

  /* double hueFromDistance(double distance)
    Calculates the hue of a marker based on its distance from the user

    Args:
      distance (double): Distance between the marker and the user

    Returns:
      double: Hue of the marker
  */
  double hueFromDistance(double distance) {
    Map<double, double> hueMap = {
      0.020: BitmapDescriptor.hueRed,
      0.050: BitmapDescriptor.hueOrange,
      0.075: BitmapDescriptor.hueYellow,
      0.150: BitmapDescriptor.hueGreen,
      0.200: BitmapDescriptor.hueBlue,
      0.500: BitmapDescriptor.hueViolet,
    };

    for (var key in hueMap.keys) {
      if (distance <= key) {
        return hueMap[key]!;
      }
    }

    return BitmapDescriptor.hueViolet;
  }

  /* void generateMarkers(List<List<double>> latLongList)
    Generates a list of Marker components from a list of lat/long pairs 

    Args:
      latLongList (List<List<double>>): List of lat/long pairs
  */
  void generateMarkers(List<List<double>> latLongList) async {
    for (int i = 0; i < latLongList.length; i++) {
      double distanceFromUser =
          distance(_currentPos, LatLng(latLongList[i][0], latLongList[i][1]));
      double hue = hueFromDistance(distanceFromUser);

      //double hue = (i * 73) % 255; // Generate hue based on post index
      BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(hue);

      markerList.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(latLongList[i][0], latLongList[i][1]),
        icon: markerIcon,
        alpha: 0.75,
      ));
    }
    print("Generated markers");
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
      //padding: const EdgeInsets.only(left: 15, right: 15),
      child: _currentPos == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.secondary700,
              strokeWidth: 7,
              backgroundColor: AppColors.secondary500,
            ))
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  rotateGesturesEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _currentPos!,
                    zoom: 13,
                  ),
                  gestureRecognizers: {
                    Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                  markers: markerList,
                ),
                const Center(
                  heightFactor: 2.5,
                  child: SizedBox(
                      width: 200,
                      height: 55,
                      child: CustomTextBox(
                        color: AppColors.tertiary500,
                        heading: "Artwork Map",
                        center: true,
                        padding: 16,
                        headingSize: 16,
                      )),
                ),
              ],
            ),
    );
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
          generateMarkers(widget.getRefreshedAnchors());
        }
      }
    });
  }
}
