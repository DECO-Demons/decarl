import 'package:decarl/components/topbar.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 96),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(heading: "In The Tower Of Sleep"),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
              child: CustomTextBox(
                heading: "This is a test textbox with an expandable heading",
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
                heading: "This is a test textbox with an expandable heading",
                color: AppColors.secondary200,
                expandable: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
              child: CustomTextBox(
                heading: "This is a test textbox with an expandable heading",
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
                heading: "This is a test textbox with an expandable heading",
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
                heading: "This is a test textbox with an expandable heading",
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                    'Cras laoreet convallis varius.',
                color: AppColors.secondary200,
                expandable: true,
              ),
            ),
          ],
        ));
  }
}
