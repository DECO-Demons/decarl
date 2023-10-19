import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/topbar.dart';
import 'package:decarl/components/appcolors.dart';

class UserPage extends StatefulWidget {
  final Function(int)? redirect;
  const UserPage({Key? key, this.redirect}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(heading: "User", onPress: widget.redirect!, index: 1),
        const Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading:
                            "This is a test textbox with an expandable heading",
                        body:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                            'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                            'Cras laoreet convallis varius.',
                        color: AppColors.secondary200,
                        expandable: true,
                      ),
                    ),
                    Padding(
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
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading:
                            "This is a test textbox with an expandable heading",
                        color: AppColors.secondary200,
                        expandable: false,
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
