import 'package:app_with_animations/model/product_model.dart';
import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget({
    Key? key,
    required this.futureData,
    required this.builder,
  }) : super(key: key);

  final Future<ProductList> futureData;
  final Widget Function(AsyncSnapshot<ProductList>) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData,
      builder: (context, AsyncSnapshot<ProductList> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        return builder(snapshot);
      },
    );
  }
}
