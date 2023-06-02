import 'package:app_with_animations/model/category_model.dart';
import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/widgets/card_widget.dart';
import 'package:app_with_animations/widgets/list_widget.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  final AsyncSnapshot<ProductList> snapshot;
  final CategoryCardModel? selectedCardModel;
  final Animation<Offset> animation;

  const ProductListWidget({
    Key? key,
    required this.snapshot,
    required this.selectedCardModel,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = snapshot.data?.products ?? [];
    final firstList = products.take(10).toList();
    final filteredProducts = products
        .where((product) =>
            product.category == selectedCardModel?.categoryCardModelName)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.36,
        child: SlideTransition(
          position: animation,
          child: ListWidget(
            count: filteredProducts.isNotEmpty
                ? filteredProducts.length
                : firstList.length,
            productData: ProductList(
                products:
                    filteredProducts.isNotEmpty ? filteredProducts : firstList),
            dir: Axis.horizontal,
            builder: (context, product) {
              return CardWidget(product: product!);
            },
          ),
        ),
      ),
    );
  }
}
