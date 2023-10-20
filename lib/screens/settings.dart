import 'package:decarl/components/userinfo.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/topbar.dart';
import 'package:decarl/components/appcolors.dart';

class SettingsPage extends StatefulWidget {
  final Function(int)? redirect;
  final String username;
  final String name;
  final Image profilePicture;
  final String location;
  final String email;

  const SettingsPage(
      {Key? key,
      this.redirect,
      required this.username,
      required this.name,
      required this.profilePicture,
      required this.location,
      required this.email})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
            heading: const Text("Settings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            onPress: widget.redirect,
            index: 1),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 16),
                        child: UserInfo(
                            name: widget.name,
                            email: widget.email,
                            location: widget.location,
                            image: widget.profilePicture)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: widget.name,
                        body: "@" + widget.username,
                        color: AppColors.secondary200,
                        image: widget.profilePicture,
                        imageRounded: true,
                        headingSize: 24,
                        bodySize: 18,
                        betweenPadding: 0,
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
