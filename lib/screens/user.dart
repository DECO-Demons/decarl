import 'package:decarl/components/imagegrid.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/topbar.dart';
import 'package:decarl/components/appcolors.dart';

class UserPage extends StatefulWidget {
  final Function(int)? redirect;
  final String username;
  final String name;
  final Image profilePicture;
  const UserPage(
      {Key? key,
      this.redirect,
      required this.username,
      required this.name,
      required this.profilePicture})
      : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(heading: widget.name, onPress: widget.redirect!, index: 1),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: widget.name,
                        body: "@" + widget.username,
                        color: AppColors.secondary200,
                        image: widget.profilePicture,
                        imageRounded: true,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: "This is a test textbox",
                        body:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                            'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                            'Cras laoreet convallis varius.',
                        color: AppColors.secondary200,
                        expandable: false,
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.only(left: 32, right: 32, bottom: 16),
                        child: ImageGrid(color: AppColors.secondary200))
                  ],
                ))),
      ],
    );
  }
}
