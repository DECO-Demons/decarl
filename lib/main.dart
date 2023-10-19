import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarl/firebase_manager.dart';
import 'package:decarl/screens/ar.dart';
import 'package:flutter/material.dart';

import 'components/appcolors.dart';
import 'components/navbar.dart';
import 'components/textbox.dart';
import 'components/topbar.dart';
import 'components/textbox.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:decarl/firebase_manager.dart';
import 'firebase_options.dart';
import 'screens/ar.dart' show ARWidget;
import 'screens/map.dart' show MapPage;
import 'screens/home.dart' show HomePage;

List<List<double>> posData = [];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int defaultPageIndex;
  late int selectedPageIndex;
  FirebaseManager firebaseManager = FirebaseManager();
  bool _initialized = false;
  bool _error = false;

  getAnchors() async {
    firebaseManager.anchorCollection!.get().then(
      (querySnapshot) {
        for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
          GeoPoint geoPoint = docSnapshot.get("position")["geopoint"];
          posData.add([geoPoint.latitude, geoPoint.longitude]);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    defaultPageIndex = 1;
    selectedPageIndex = defaultPageIndex;
    
    firebaseManager.initializeFlutterFire().then((value) => setState(() {
          _initialized = value;
          _error = !value;
          getAnchors();
        }));
    
    super.initState();
  }

  final _pageController = PageController(
    // Index of home screen
    initialPage: 1,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handleNavSelection(int index) {
    setState(() {
      selectedPageIndex = index;
    });
    _pageController.animateToPage(selectedPageIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(
      children: [
        Scaffold(
          body: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            // All pages
            children: [
              ARWidget(),
              const HomePage(),
              MapPage(
                locationData: posData,
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            // Navbar
            child: Navbar(handleNavSelection: handleNavSelection)),
      ],
    ));
  }
}
