import 'package:app_with_animations/model/category_model.dart';
import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/widgets/card_widget.dart';
import 'package:app_with_animations/widgets/list_widget.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatefulWidget {
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
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState == ConnectionState.waiting) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                        begin: Alignment(-1 - _controller.value * 3, -0.3),
                        end: Alignment(1 + _controller.value * 3, -0.3),
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[100]!,
                          Colors.grey[300]!,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      final products = widget.snapshot.data?.products ?? [];
      final firstList = products.take(10).toList();
      final filteredProducts = products
          .where((product) =>
              product.category ==
              widget.selectedCardModel?.categoryCardModelName)
          .toList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
          child: SlideTransition(
            position: widget.animation,
            child: ListWidget(
              count: filteredProducts.isNotEmpty
                  ? filteredProducts.length
                  : firstList.length,
              productData: ProductList(
                  products: filteredProducts.isNotEmpty
                      ? filteredProducts
                      : firstList),
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
}
