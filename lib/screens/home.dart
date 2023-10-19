import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class HomePage extends StatefulWidget {
  final Function(String)? redirect;
  const HomePage({Key? key, this.redirect}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 24),
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
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: CustomTextBox(
                    heading: "User screen",
                    color: AppColors.secondary200,
                    expandable: false,
                  ),
                ),
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
              ],
            )));
  }
}
