import 'package:flutter/material.dart';
import 'appcolors.dart';

/*
  RoundButton
  A custom button widget
*/
class RoundButton extends StatefulWidget {
  final Icon icon;
  final int? index; // The index of this button

  final Function()? onPress; // Callback function for when the button is pressed
  final Function(int)?
      onPressNav; // Callback function for when the button is pressed and navigation is involved

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
            // If it's a navigation button
            if (widget.onPressNav != null) {
              widget.onPressNav!(widget.index!);
              // If it's a regular callback
            } else if (widget.onPress != null) {
              widget.onPress!();
            }
          },
          child: widget.icon,
        ));
  }
}
