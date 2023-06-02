import 'package:flutter/material.dart';

class TitleAnimation extends StatelessWidget {
  final String text;

  const TitleAnimation({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
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
        text,
        style: const TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
