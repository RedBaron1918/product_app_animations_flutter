import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    this.iconSize = 30,
    this.height = 40,
    this.width = 40,
    this.callBack,
    this.backgroundColor = Colors.white,
    this.iconColor = const Color.fromARGB(255, 255, 96, 96),
    required this.icon,
    super.key,
  });
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function? callBack;
  final double? height;
  final double? width;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(icon),
        iconSize: iconSize,
        color: iconColor,
        onPressed: () {
          if (callBack != null) {
            callBack!();
          }
        },
      ),
    );
  }
}
