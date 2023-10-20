import 'package:flutter/material.dart';
import 'appcolors.dart';

class UserInfo extends StatefulWidget {
  final String name;
  final String email;
  final String location;
  final Image image;

  const UserInfo(
      {Key? key,
      required this.name,
      required this.email,
      required this.location,
      required this.image})
      : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Image? newImage;

  @override
  void initState() {
    newImage = Image(
      image: widget.image.image,
      width: 80,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey999, width: 2),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), child: newImage)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(
            widget.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(
            widget.email,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: Text(
            widget.location,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
