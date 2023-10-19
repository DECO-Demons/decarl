import 'package:decarl/components/topbar.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class HomePage extends StatefulWidget {
  final Function(int)? redirect;
  const HomePage({Key? key, this.redirect}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(
            heading: Text("Home",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            onPress: null),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24, bottom: 96),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
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
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: "This is a test textbox",
                        body:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                            'Donec accumsan quam augue, eget lacinia ante ultrices ut. '
                            'Cras laoreet convallis varius.',
                        color: AppColors.secondary200,
                        expandable: false,
                        image: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                          width: 50,
                        ),
                        imageRounded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        color: AppColors.secondary200,
                        expandable: false,
                        image: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                          width: 276,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          widget.redirect!(2);
                        },
                        child: const CustomTextBox(
                          heading: "Community Guidelines",
                          color: AppColors.secondary200,
                          center: true,
                        ),
                      ),
                    ),
                    const Padding(
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
                    const Padding(
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
                    const Padding(
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
                ))),
      ],
    );
  }
}
