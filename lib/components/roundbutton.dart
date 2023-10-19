import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoundButton extends StatefulWidget {
  final Icon icon;
  final EdgeInsets padding;
  final int index;
  final Function(int) onPressed;
  final Color color;

  const RoundButton(
      {Key? key,
      required this.icon,
      required this.padding,
      required this.index,
      required this.onPressed,
      required this.color})
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
    return Padding(
        padding: widget.padding,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: const Color(0xffCBC7FC),
          shape: const CircleBorder(
              side: BorderSide(color: Color(0xff0E0E0E), width: 2)),
          onPressed: () {
            widget.onPressed(widget.index);
          },
          child: widget.icon,
        ));
  }
}
