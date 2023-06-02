import 'package:flutter/material.dart';

class TitleAnimationWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const TitleAnimationWidget({
    Key? key,
    required this.text,
    this.fontSize = 36,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<TitleAnimationWidget> createState() => _TitleAnimationWidgetState();
}

class _TitleAnimationWidgetState extends State<TitleAnimationWidget> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: _key,
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      builder: (BuildContext context, double value, child) {
        return Opacity(
          opacity: value,
          child:
              Padding(padding: EdgeInsets.only(top: value * 10), child: child),
        );
      },
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
