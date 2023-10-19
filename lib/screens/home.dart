import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Align(
          alignment: Alignment.topCenter,
          child: CustomTextBox(
            heading: "This is a test textbox with an expandable heading",
            body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                'Cras laoreet convallis varius.',
            color: AppColors.secondaryLight,
            expandable: true,
          )),
    );
  }
}
