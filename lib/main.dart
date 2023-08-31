import 'package:flutter/material.dart';
import 'screens/map.dart' show MapPage;
import 'screens/home.dart' show HomePage;

void main() {
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
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Decarl Test')),
          ),
          body: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            // All pages
            children: const [
              HomePage(),
              MapPage(),
            ],
          )),
    );
  }
}
