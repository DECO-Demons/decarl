import 'package:decarl/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:decarl/components/appcolors.dart';
import 'package:lucide_icons/lucide_icons.dart';

/* 
  Welcome1
  The first welcome screen
*/
class Welcome1 extends StatefulWidget {
  final Function(int)? redirect;

  const Welcome1({
    Key? key,
    this.redirect,
  }) : super(key: key);

  @override
  State<Welcome1> createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 108.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome to the",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey999,
                ),
              ),
              const Text(
                "ultimate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text(
                  "art creation space",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey999,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomTextBox(
                  color: Colors.white,
                  image: Image.asset(
                    'assets/logo_decarl.png',
                    width: 212,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Inspiration and innovation is all around you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey999,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.redirect!(1);
                },
                child: const CustomTextBox(
                  color: AppColors.primary500,
                  heading: "Get Started",
                  customIcon: Icon(LucideIcons.arrowRight),
                  center: true,
                  padding: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey999,
                      ),
                    ),
                    TextSpan(
                      text: "Sign in",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary600,
                          decoration: TextDecoration.underline),
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
