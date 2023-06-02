import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/views/detail_page.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
    required this.productData,
    required this.builder,
    required this.dir,
    required this.count,
  }) : super(key: key);

  final ProductList productData;
  final int count;
  final Widget Function(BuildContext context, Product? product) builder;
  final Axis dir;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: dir,
      itemCount: count,
      itemBuilder: (context, index) {
        Product product = productData.products![index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(product: product),
              ),
            );
          },
          child: builder(context, product),
        );
      },
    );
  }
}
