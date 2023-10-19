import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

class CustomTextBox extends StatefulWidget {
  final String? heading;
  final String? body;
  final Color color;
  final bool? expandable;
  final bool? center;

  final Image? image;
  final bool? imageRounded;

  const CustomTextBox(
      {Key? key,
      this.heading,
      this.body,
      required this.color,
      this.expandable,
      this.center,
      this.image,
      this.imageRounded})
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
          padding: const EdgeInsets.all(24),
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
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.grey999, width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: widget.image,
                        ),
                      )
                    : widget.image,
              ),
              Expanded(
                child: Column(children: [
                  if (widget.heading != null)
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: (!isExpandable || isExpanded) &&
                                  widget.body != null
                              ? 16
                              : 0),
                      child: Row(children: [
                        Expanded(
                          child: Text(widget.heading!,
                              textAlign: widget.center != null && widget.center!
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: const TextStyle(
                                  color: AppColors.grey900,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold)),
                        ),
                        isExpandable
                            ? IconButton(
                                onPressed: expandBox,
                                icon: Icon(isExpanded
                                    ? LucideIcons.minus
                                    : LucideIcons.plus))
                            : const SizedBox.shrink(),
                      ]),
                    ),
                  if ((!isExpandable || isExpanded) && widget.body != null)
                    Text(widget.body!,
                        textAlign: widget.center != null && widget.center!
                            ? TextAlign.center
                            : TextAlign.start,
                        style: const TextStyle(
                            color: AppColors.grey900,
                            decoration: TextDecoration.none))
                ]),
              ),
            ],
          )),
    );
  }
}
