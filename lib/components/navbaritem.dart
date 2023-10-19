import 'package:flutter/material.dart';

class NavbarItem extends StatefulWidget {
  final Icon icon;
  final double bottomPad;
  const NavbarItem({Key? key, required this.icon, required this.bottomPad})
      : super(key: key);

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(left: 8.0, right: 8.0, bottom: widget.bottomPad),
        child: FloatingActionButton(
          onPressed: () {},
          child: widget.icon,
        ));
  }
}
