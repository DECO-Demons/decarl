import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'roundbutton.dart';
import 'appcolors.dart';

/*
  TopBar
  A widget that displays the top bar at the top of the screen
  It is used in all info pages
*/
class TopBar extends StatefulWidget {
  final Widget
      heading; // The heading of the top bar, can be a widget to allow for custom text boxes in the top bar
  final Function(int)? onPress;
  final int? index; // The index of the page to navigate to (if exists)

  const TopBar({Key? key, required this.heading, this.onPress, this.index})
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
          mainAxisAlignment: widget.onPress != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.onPress != null)
              RoundButton(
                  icon: const Icon(
                    LucideIcons.arrowLeft,
                    color: AppColors.grey900,
                  ),
                  onPressNav: widget.onPress,
                  index: widget.index,
                  color: AppColors.tertiary500,
                  pressedColor: AppColors.tertiary600),
            widget.heading,
          ]),
    );
  }
}
