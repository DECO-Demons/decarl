import 'package:decarl/screens/ar.dart';
import 'package:decarl/screens/user.dart';
import 'package:flutter/material.dart';

import 'components/navbar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'screens/ar.dart' show ARWidget;
import 'screens/map.dart' show MapPage;
import 'screens/home.dart' show HomePage;

List<List<double>> posData = [];

void main() async {
  List<String> rawPosData = await fetchArtData();

  for (var str in rawPosData) {
    List<String> parts = str.split(',');
    double first = double.parse(parts[0]);
    double second = double.parse(parts[1]);
    posData.add([first, second]);
  }

  runApp(const MainApp());
}

Future<List<String>> fetchArtData() async {
  List<String> artList = [];
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('art').get();
  if (snapshot.exists) {
    Object? data = snapshot.value;

    if (data is List) {
      for (var entry in data) {
        if (entry != null) {
          //print(entry["lat_lon"]);
          artList.add(entry["lat_lon"]);
        }
      }
    }
  } else {
    print('No data available.');
  }

  return artList;
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int defaultPageIndex;
  late int selectedPageIndex;

  @override
  void initState() {
    defaultPageIndex = 1;
    selectedPageIndex = defaultPageIndex;
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
              HomePage(redirect: handleNavSelection),
              MapPage(
                locationData: posData,
              ),
              UserPage(
                redirect: handleNavSelection,
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
