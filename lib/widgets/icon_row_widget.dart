import 'package:flutter/material.dart';

class IconTextWidgetRow extends StatelessWidget {
  const IconTextWidgetRow({
    this.backgroundColor,
    required this.icon,
    required this.text,
    required this.color,
    this.textColor = const Color(0xFF333333),
    this.iconSize,
    this.textSize = 22,
    this.align = MainAxisAlignment.start,
    super.key,
  });
  final MainAxisAlignment align;
  final IconData icon;
  final String text;
  final Color color;
  final Color? textColor;
  final double? iconSize;
  final double? textSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: align,
        children: [
          Icon(
            icon,
            color: color,
            size: iconSize,
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
