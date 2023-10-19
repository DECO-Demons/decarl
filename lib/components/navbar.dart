import 'package:decarl/components/roundbutton.dart';
import 'package:flutter/material.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

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
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: RoundButton(
              index: 0,
              icon: const Icon(
                LucideIcons.camera,
                color: AppColors.grey900,
              ),
              onPress: widget.handleNavSelection,
              color: AppColors.secondary500,
              pressedColor: AppColors.secondary600,
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
          child: RoundButton(
            index: 1,
            icon: const Icon(
              LucideIcons.globe,
              color: AppColors.grey900,
            ),
            onPress: widget.handleNavSelection,
            color: AppColors.secondary500,
            pressedColor: AppColors.secondary600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: RoundButton(
            index: 2,
            icon: const Icon(
              LucideIcons.mapPin,
              color: AppColors.grey900,
            ),
            onPress: widget.handleNavSelection,
            color: AppColors.secondary500,
            pressedColor: AppColors.secondary600,
          ),
        ),
      ],
    );
  }
}
