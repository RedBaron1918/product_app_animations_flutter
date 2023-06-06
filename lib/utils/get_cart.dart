import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/utils/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String cacheKey = 'checkOutId';

void saveCheckOut(String productId) async {
  final prefs = await SharedPreferences.getInstance();

  final List<String> checkOut = prefs.containsKey(cacheKey)
      ? prefs.getStringList(cacheKey) as List<String>
      : <String>[];

  checkOut.contains(productId)
      ? checkOut.remove(productId)
      : checkOut.add(productId);

  prefs.setStringList(cacheKey, checkOut);
}

Future<bool> isCheckOut(Product product) async {
  return (await getCheckOuts()).contains(product);
}

Future<List<Product?>> getCheckOuts() async {
  final prefs = await SharedPreferences.getInstance();
  final checkOut = prefs.containsKey(cacheKey)
      ? prefs.getStringList(cacheKey) as List<String>
      : <String>[];
  return productListResponse!.products!
      .map((element) {
        if (checkOut.contains(element.id.toString())) {
          return element;
        }
      })
      .toList()
      .where((element) => element != null)
      .toList();
}
