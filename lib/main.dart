import 'package:decarl/screens/ar.dart';
import 'package:decarl/screens/externalmodelmanagementexample.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'screens/ar.dart' show arApp;
import 'screens/map.dart' show MapPage;
import 'screens/home.dart' show HomePage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('art/1').get();
  if (snapshot.exists) {
    print(snapshot.value);
  } else {
    print('No data available.');
  }

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _pageController = PageController(
    // Index of home screen
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:
            arApp()); /* Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Decarl Test')),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => arApp(),));
                  },
                  icon: Icon(Icons.camera))
            ],
          ),
          body: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            // All pages
            children: const [
              HomePage(),
              MapPage(),
            ],
          )), */
  }
}
