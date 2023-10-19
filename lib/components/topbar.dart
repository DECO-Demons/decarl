import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'roundbutton.dart';
import 'appcolors.dart';

class TopBar extends StatefulWidget {
  final String heading;
  final Function(String)? onPressRoute;
  final String? prevPage;

  const TopBar(
      {Key? key, required this.heading, this.onPressRoute, this.prevPage})
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

  void backPage(String prevPage) {
    setState(() {
      //selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
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
          mainAxisAlignment: widget.onPressRoute != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.onPressRoute != null)
              RoundButton(
                  icon: const Icon(
                    LucideIcons.arrowLeft,
                    color: AppColors.grey900,
                  ),
                  onPressRoute: widget.onPressRoute,
                  prevPage: widget.prevPage,
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
