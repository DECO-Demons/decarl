import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarl/components/imagegrid.dart';
import 'package:decarl/firebase_manager.dart';
import 'package:decarl/screens/ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/navbar.dart';
import 'components/appcolors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:decarl/firebase_manager.dart';
import 'firebase_options.dart';

import 'screens/ar.dart' show ARWidget;
import 'screens/map.dart' show MapPage;
import 'screens/testing.dart' show HomePage;
import 'screens/user.dart' show UserPage;
import 'screens/settings.dart' show SettingsPage;
import 'screens/communityguidelines.dart' show CommunityGuidelines;

List<List<double>> posData = [];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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

  List<List<double>> getAnchors() {
    List<List<double>> anchorLocations = [];
    firebaseManager.anchorCollection!.get().then(
      (querySnapshot) {
        for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
          GeoPoint geoPoint = docSnapshot.get("position")["geopoint"];
          anchorLocations.add([geoPoint.latitude, geoPoint.longitude]);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return anchorLocations;
  }

  @override
  void initState() {
    defaultPageIndex = 1;
    selectedPageIndex = defaultPageIndex;

    firebaseManager
        .initializeFlutterFire()
        .then((value) => {posData = getAnchors()});

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.tertiary100),
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
                  //HomePage(redirect: handleNavSelection),

                  UserPage(
                    redirect: handleNavSelection,
                    username: "test",
                    name: "Test User",
                    profilePicture: Image.asset(
                      "assets/avatar.png",
                      width: 50,
                    ),
                    followerCount: 1050,
                    followingCount: 5000,
                  ),
                  SettingsPage(
                      redirect: handleNavSelection,
                      username: "test",
                      name: "Test User",
                      location: "Test Location",
                      email: "test@email.com",
                      profilePicture: Image.asset(
                        "assets/avatar.png",
                        width: 50,
                      )),
                  CommunityGuidelines(
                    redirect: handleNavSelection,
                  ),

                  MapPage(
                    initialLocationData: posData,
                    getRefreshedAnchors: getAnchors,
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
