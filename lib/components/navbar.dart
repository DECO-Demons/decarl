import 'package:flutter/material.dart';

import 'package:decarl/components/navbaritem.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;
  const Navbar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        NavbarItem(
          icon: Icon(Icons.home_outlined),
          bottomPad: 8.0,
        ),
        NavbarItem(
          icon: Icon(Icons.map_outlined),
          bottomPad: 32.0,
        ),
        NavbarItem(
          icon: Icon(Icons.travel_explore),
          bottomPad: 8.0,
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
