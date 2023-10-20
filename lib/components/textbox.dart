import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

/*
  CustomTextBox
  A widget that displays a box with a heading, body, image and/or icon
*/
class CustomTextBox extends StatefulWidget {
  final String? heading;
  final String? body;
  final double? headingSize;
  final double? bodySize;
  final int? headingWeight;
  final int? bodyWeight;

  final double? betweenPadding;

  final double? padding;
  final Color color;
  final bool? expandable;
  final Icon? customIcon;
  final bool? center;

  final Image? image;
  final bool? imageRounded;
  final bool? imageOutline;

  const CustomTextBox(
      {Key? key,
      this.heading,
      this.body,
      this.padding = 24,
      required this.color,
      this.expandable = false,
      this.center,
      this.image,
      this.imageRounded,
      this.headingSize,
      this.bodySize,
      this.headingWeight,
      this.bodyWeight,
      this.betweenPadding = 16,
      this.imageOutline = false,
      this.customIcon})
      : super(key: key);

  @override
  State<CustomTextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  late bool isExpandable;
  bool isExpanded = false;
  /* void initState()
    Callback function for when the widget is created
  */
  @override
  void initState() {
    super.initState();

    if (widget.expandable == null) {
      isExpandable = false;
    } else {
      isExpandable = widget.expandable!;
    }
  }

  void expandBox() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.all(widget.padding!),
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.rectangle,
            border: Border.all(color: AppColors.grey900, width: 2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: AppColors.grey900,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: widget.image != null && widget.imageRounded == true
                    ? const EdgeInsets.only(right: 16.0)
                    : EdgeInsets.zero,
                child: widget.image != null && widget.imageRounded == true
                    ? Container(
                        decoration: widget.imageOutline == true
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.grey999, width: 2),
                              )
                            : const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            child: widget.image,
                          ),
                        ),
                      )
                    : widget.image,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: widget.center != true
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      if (widget.heading != null)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: (!isExpandable || isExpanded) &&
                                      widget.body != null
                                  ? widget.betweenPadding!
                                  : 0),
                          child: Row(children: [
                            Expanded(
                              child: Text(widget.heading!,
                                  textAlign:
                                      widget.center != null && widget.center!
                                          ? TextAlign.center
                                          : TextAlign.start,
                                  style: TextStyle(
                                      color: AppColors.grey900,
                                      decoration: TextDecoration.none,
                                      fontWeight: widget.headingWeight != null
                                          ? FontWeight
                                              .values[widget.headingWeight!]
                                          : FontWeight.w800,
                                      fontSize: widget.headingSize ?? 18)),
                            ),
                            // If it can be expanded, create a button to expand it
                            isExpandable
                                ? IconButton(
                                    onPressed: expandBox,
                                    icon: Icon(isExpanded
                                        ? LucideIcons.minus
                                        : LucideIcons.plus))
                                // If there is a custom icon, use that instead
                                : widget.customIcon != null
                                    ? Icon(widget.customIcon!.icon)
                                    : const SizedBox.shrink(),
                          ]),
                        ),
                      if ((!isExpandable || isExpanded) && widget.body != null)
                        Text(widget.body!,
                            textAlign: widget.center != null && widget.center!
                                ? TextAlign.center
                                : TextAlign.start,
                            style: TextStyle(
                              color: AppColors.grey900,
                              decoration: TextDecoration.none,
                              fontWeight: widget.bodyWeight != null
                                  ? FontWeight.values[widget.bodyWeight!]
                                  : FontWeight.w500,
                              fontSize: widget.bodySize ?? 14,
                            ))
                    ]),
              ),
            ],
          )),
    );
  }
}
