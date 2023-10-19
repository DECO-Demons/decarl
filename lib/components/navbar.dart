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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavbarItem(
          index: 0,
          icon: Icon(Icons.home_outlined),
          bottomPad: 8.0,
        ),
        NavbarItem(
          index: 1,
          icon: Icon(Icons.map_outlined),
          bottomPad: 32.0,
        ),
        NavbarItem(
          index: 2,
          icon: Icon(Icons.travel_explore),
          bottomPad: 8.0,
        ),
      ],
    );
  }
}
