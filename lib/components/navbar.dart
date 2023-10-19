import 'package:decarl/components/roundbutton.dart';
import 'package:flutter/material.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'colors.dart';

class Navbar extends StatefulWidget {
  final Function(int) handleNavSelection;

  const Navbar({Key? key, required this.handleNavSelection}) : super(key: key);

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundButton(
          index: 0,
          icon: const Icon(
            LucideIcons.home,
            color: Color(0xff0E0E0E),
          ),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          onPressed: widget.handleNavSelection,
          color: const Color(0xffCBC7FC),
        ),
        RoundButton(
          index: 1,
          icon: const Icon(
            LucideIcons.globe,
            color: Color(0xff0E0E0E),
          ),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 32.0),
          onPressed: widget.handleNavSelection,
          color: const Color(0xffCBC7FC),
        ),
        RoundButton(
          index: 2,
          icon: const Icon(
            LucideIcons.mapPin,
            color: Color(0xff0E0E0E),
          ),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          onPressed: widget.handleNavSelection,
          color: const Color(0xffCBC7FC),
        ),
      ],
    );
  }
}
