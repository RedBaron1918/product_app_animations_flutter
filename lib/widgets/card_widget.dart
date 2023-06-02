import 'package:app_with_animations/consts/const_colors.dart';
import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/widgets/fade_in_image.dart';
import 'package:app_with_animations/widgets/heart_icon.dart';
import 'package:app_with_animations/widgets/text_container.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Card(
        color: ConstColors.cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 140,
                  child: FadeInImageWidget(
                    photo: product!.images![0],
                    radius: 6,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(top: 8, right: 8, child: HeartIcon())
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (product?.title?.length ?? 0) > 13
                        ? '${product!.title!.substring(0, 13)}...'
                        : product?.title ?? '',
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextContainer(text: "\$${product?.price}"),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
