import 'package:decarl/components/roundbutton.dart';
import 'package:decarl/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:decarl/components/appcolors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Welcome2 extends StatefulWidget {
  final Function(int)? redirect;

  const Welcome2({
    Key? key,
    this.redirect,
  }) : super(key: key);

  @override
  State<Welcome2> createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.tertiary100,
        body: Stack(children: [
          Image.asset("assets/welcome/splash2.png", fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32, bottom: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextBox(
                  color: Colors.white,
                  headingSize: 28,
                  headingWeight: 8,
                  heading: "Find unique artwork around the city\n\n\n",
                  center: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 105.0),
              child: RoundButton(
                  icon: const Icon(
                    LucideIcons.arrowRight,
                    color: AppColors.grey999,
                  ),
                  color: AppColors.secondary200,
                  pressedColor: AppColors.secondary400,
                  onPress: () {
                    widget.redirect!(2);
                  }),
            ),
          )
        ]));
  }
}
