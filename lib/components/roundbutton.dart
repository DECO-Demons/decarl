import 'package:flutter/material.dart';
import 'appcolors.dart';

class RoundButton extends StatefulWidget {
  final Icon icon;
  final int? index; // The index of this button

  final Function()? onPress;
  final Function(int)? onPressNav;

  final Color color;
  final Color pressedColor;

  const RoundButton(
      {Key? key,
      required this.icon,
      this.index,
      this.onPressNav,
      this.onPress,
      required this.color,
      required this.pressedColor})
      : super(key: key);

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey900,
              spreadRadius: 0,
              blurRadius: 0,

              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: widget.color,
          splashColor: widget.pressedColor,
          shape: const CircleBorder(
              side: BorderSide(color: AppColors.grey900, width: 2)),
          onPressed: () {
            if (widget.onPressNav != null) {
              widget.onPressNav!(widget.index!);
            } else if (widget.onPress != null) {
              widget.onPress!();
            }
          },
          child: widget.icon,
        ));
  }
}
