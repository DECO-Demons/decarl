import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

class CustomTextBox extends StatefulWidget {
  final String? heading;
  final String? body;
  final Color color;
  final bool expandable;

  const CustomTextBox(
      {Key? key,
      this.heading,
      this.body,
      required this.color,
      required this.expandable})
      : super(key: key);

  @override
  State<CustomTextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();
  }

  bool isExpanded = false;

  void expandBox() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.rectangle,
          border: Border.all(color: AppColors.outline, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.outline,
              spreadRadius: 0,
              blurRadius: 0,

              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          widget.heading == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(
                      bottom: (!widget.expandable || isExpanded) &&
                              widget.body != null
                          ? 16
                          : 0),
                  child: Row(children: [
                    Expanded(
                      child: Text(widget.heading!,
                          style: const TextStyle(
                              color: AppColors.outline,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold)),
                    ),
                    widget.expandable
                        ? IconButton(
                            onPressed: expandBox,
                            icon: Icon(isExpanded
                                ? LucideIcons.minus
                                : LucideIcons.plus))
                        : const SizedBox.shrink(),
                  ]),
                ),
          (!widget.expandable || isExpanded) && widget.body != null
              ? Text(widget.body!,
                  style: const TextStyle(
                      color: AppColors.outline,
                      decoration: TextDecoration.none))
              : const SizedBox.shrink(),
        ]));
  }
}
