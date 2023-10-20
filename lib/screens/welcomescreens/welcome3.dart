import 'package:decarl/components/roundbutton.dart';
import 'package:decarl/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:decarl/components/appcolors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Welcome3 extends StatefulWidget {
  final Function(int)? redirect;

  const Welcome3({
    Key? key,
    this.redirect,
  }) : super(key: key);

  @override
  State<Welcome3> createState() => _Welcome3State();
}

class _Welcome3State extends State<Welcome3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.tertiary100,
        body: Stack(children: [
          Image.asset("assets/welcome/splash3.png", fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32, bottom: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextBox(
                  color: Colors.white,
                  headingSize: 28,
                  headingWeight: 8,
                  heading: "Create & upload your own art pieces\n\n\n",
                  center: true,
                ),
              ],
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 520.0),
            child: RoundButton(
                icon: const Icon(
                  LucideIcons.arrowRight,
                  color: AppColors.grey999,
                ),
                color: AppColors.secondary200,
                pressedColor: AppColors.secondary400,
                onPress: () {
                  widget.redirect!(4);
                }),
          ))
        ]));
  }
}
