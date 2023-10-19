import 'package:decarl/components/topbar.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
<<<<<<< Updated upstream
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
=======
>>>>>>> Stashed changes
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: CustomTextBox(
              heading: "This is a test textbox with an expandable heading",
              body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                  'Cras laoreet convallis varius.',
              color: AppColors.secondaryLight,
              expandable: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: CustomTextBox(
              heading: "This is a test textbox",
              body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                  'Cras laoreet convallis varius.',
              color: AppColors.secondaryLight,
              expandable: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: CustomTextBox(
              heading: "This is a test textbox with an expandable heading",
              color: AppColors.secondaryLight,
              expandable: false,
            ),
          ),
        ],
<<<<<<< Updated upstream
=======
>>>>>>> 2ada3eae81c43c89fb0690191725cb0ef677e96d
>>>>>>> Stashed changes
      ),
=======
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TopBar(heading: "Home"),
        Padding(
          padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: CustomTextBox(
            heading: "This is a test textbox with an expandable heading",
            body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
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
            body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
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
      ],
>>>>>>> Stashed changes
    );
  }
}
