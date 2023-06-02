import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({
    this.textColor = Colors.white,
    this.backgroundColor = const Color.fromARGB(255, 255, 96, 96),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    required this.text,
    super.key,
  });
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
