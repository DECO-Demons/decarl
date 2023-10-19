import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appcolors.dart';

class ImageGrid extends StatefulWidget {
  final Color color;

  const ImageGrid({Key? key, required this.color}) : super(key: key);

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  late bool isExpandable;
  bool isExpanded = false;

  final List<String> images = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent uploads",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.grey999),
              textAlign: TextAlign.start,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemCount: images.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Image.network(images[index]);
              },
            ),
          ],
        ));
  }
}
