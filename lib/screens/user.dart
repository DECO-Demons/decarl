import 'package:decarl/components/imagegrid.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/topbar.dart';
import 'package:decarl/components/appcolors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserPage extends StatefulWidget {
  final Function(int)? redirect;
  final String username;
  final String name;
  final Image profilePicture;

  final int followerCount;
  final int followingCount;

  const UserPage(
      {Key? key,
      this.redirect,
      required this.username,
      required this.name,
      required this.profilePicture,
      required this.followerCount,
      required this.followingCount})
      : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

const List<String> images = [
  'assets/tempimg/1.png',
  'assets/tempimg/2.png',
  'assets/tempimg/3.png',
  'assets/tempimg/4.png',
  'assets/tempimg/5.png',
  'assets/tempimg/6.png',
];

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
            heading: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  width: 110,
                  height: 62,
                  child: CustomTextBox(
                    color: AppColors.secondary500,
                    heading: "Followers",
                    body: widget.followerCount.toString(),
                    center: true,
                    bodySize: 18,
                    padding: 8,
                    betweenPadding: 0,
                    headingWeight: 4,
                    bodyWeight: 8,
                  ),
                ),
              ),
              SizedBox(
                width: 110,
                height: 62,
                child: CustomTextBox(
                  color: AppColors.secondary500,
                  heading: "Following",
                  body: widget.followingCount.toString(),
                  center: true,
                  bodySize: 18,
                  padding: 8,
                  betweenPadding: 0,
                  headingWeight: 4,
                  bodyWeight: 8,
                ),
              ),
            ]),
            //onPress: widget.redirect!,
            index: 1),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.redirect!(2);
                      },
                      child: Padding(
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
                          imageOutline: true,
                          customIcon: const Icon(LucideIcons.settings),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.only(left: 32, right: 32, bottom: 118),
                        child: ImageGrid(
                            color: AppColors.secondary200, images: images))
                  ],
                ))),
      ],
    );
  }
}
