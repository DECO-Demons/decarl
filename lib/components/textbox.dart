import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

class CustomTextBox extends StatefulWidget {
  final String? heading;
  final String? body;
  final Color color;
  final bool? expandable;

  const CustomTextBox(
      {Key? key, this.heading, this.body, required this.color, this.expandable})
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
            if (widget.heading != null)
              Padding(
                padding: EdgeInsets.only(
                    bottom: (!isExpandable || isExpanded) && widget.body != null
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
                  style: const TextStyle(
                      color: AppColors.outline,
                      decoration: TextDecoration.none))
          ])),
    );
  }
}
