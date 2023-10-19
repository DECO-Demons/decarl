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
          alignment: Alignment.center,
          child: CustomTextBox(
            heading:
                "Any content uploaded to DECARL must not be discriminatory in nature.",
            body:
                'Discriminatory uploads include but are not limited to content that is racist, homophobic, ableist, transphobic, sexist and ageist.    ',
            color: AppColors.secondaryDefault,
            expandable: true,
          )),
    );
  }
}
