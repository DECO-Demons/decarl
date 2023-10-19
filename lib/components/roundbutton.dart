import 'package:flutter/material.dart';
import 'appcolors.dart';

class RoundButton extends StatefulWidget {
  final Icon icon;
  final int index; // The index of this button
  final Function(int) onPressed;
  final Color color;
  final Color pressedColor;

  const RoundButton(
      {Key? key,
      required this.icon,
      required this.index,
      required this.onPressed,
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
              color: AppColors.outline,
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
              side: BorderSide(color: AppColors.outline, width: 2)),
          onPressed: () {
            widget.onPressed(widget.index);
          },
          child: widget.icon,
        ));
  }
}
