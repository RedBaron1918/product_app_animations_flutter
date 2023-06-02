import 'package:flutter/material.dart';

class IconTextWidgetColumn extends StatelessWidget {
  const IconTextWidgetColumn({
    this.backgroundColor,
    required this.icon,
    required this.text,
    required this.color,
    required this.secondText,
    this.textColor = const Color(0xFF333333),
    this.iconSize,
    this.textSize = 22,
    this.align = MainAxisAlignment.start,
    this.cross = CrossAxisAlignment.center,
    super.key,
  });
  final MainAxisAlignment align;
  final CrossAxisAlignment cross;
  final IconData icon;
  final String text;
  final Color color;
  final String secondText;
  final Color? textColor;
  final double? iconSize;
  final double? textSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: align,
        crossAxisAlignment: cross,
        children: [
          Row(
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
          Text(
            secondText,
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
