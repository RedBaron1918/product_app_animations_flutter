import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FadeInImageWidget extends StatelessWidget {
  const FadeInImageWidget(
      {this.fit,
      this.radius = 100,
      this.height = 40,
      required this.photo,
      super.key});
  final String photo;
  final double? height;
  final BoxFit? fit;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: photo,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
