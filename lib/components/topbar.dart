import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'roundbutton.dart';
import 'appcolors.dart';

class TopBar extends StatefulWidget {
  final String heading;
  final int? prevPageIndex;

  const TopBar({Key? key, required this.heading, this.prevPageIndex})
      : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();
  }

  void backPage(int index) {
    setState(() {
      //selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      height: 150,
      padding: EdgeInsets.only(top: safePadding, left: 24, right: 24),
      decoration: BoxDecoration(
          color: AppColors.primary200,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey900,
              spreadRadius: 0,
              blurRadius: 0,

              offset: Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundButton(
                icon: const Icon(
                  LucideIcons.arrowLeft,
                  color: AppColors.grey900,
                ),
                index: 3,
                onPressed: backPage,
                color: AppColors.tertiary500,
                pressedColor: AppColors.tertiary600),
            Text(widget.heading,
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w900)),
          ]),
    );
  }
}