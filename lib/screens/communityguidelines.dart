import 'package:decarl/components/topbar.dart';
import 'package:flutter/material.dart';

import 'package:decarl/components/textbox.dart';
import 'package:decarl/components/appcolors.dart';

class CommunityGuidelines extends StatefulWidget {
  final Function(int)? redirect;
  const CommunityGuidelines({Key? key, this.redirect}) : super(key: key);

  @override
  State<CommunityGuidelines> createState() => _CommunityGuidelinesState();
}

class _CommunityGuidelinesState extends State<CommunityGuidelines> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
            heading: const Text("Community Guidelines",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            onPress: widget.redirect!,
            index: 1),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24, bottom: 96),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                        padding:
                            EdgeInsets.only(left: 32, right: 32, bottom: 16),
                        child: Text(
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            "To keep our community happy and safe, we've "
                            "devised a set of guidelines for all our users to follow:")),
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: "Any content uploaded to Decarl must not be "
                            "discriminatory in nature.",
                        body: "Discriminatory uploads include but are not "
                            "limited to content that is racist, homophobic, "
                            "ableist, transphobic, sexist and ageist.",
                        color: AppColors.secondary200,
                        expandable: true,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: "All users must adhere to the approved "
                            "art upload locations.",
                        body: "Prohibited locations include but are not "
                            "limited to school buildings, religious/sacred "
                            "sites and places of worship.",
                        color: AppColors.secondary200,
                        expandable: true,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        heading: "The uploading of plagiarised art is"
                            "strictly prohibited.",
                        body: "You must be the creator of any art you upload "
                            "to Decarl.",
                        color: AppColors.secondary200,
                        expandable: true,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(
                            left: 32, right: 32, top: 16, bottom: 32),
                        child: Text(
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900),
                            "Breach of these guidelines  will result in the "
                            "prompt suspension or banning of your Decarl "
                            "account")),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: CustomTextBox(
                        body: "Thanks for following these guidelines and "
                            "helping keep DECARL a safe, happy and creative space!"
                            "\n\n~ The Decarl Team",
                        image: Image.asset(
                          "assets/logo_decarl.png",
                          width: 100,
                        ),
                        imageRounded: true,
                        color: AppColors.secondary200,
                        expandable: false,
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
