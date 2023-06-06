import 'dart:convert';
import 'package:app_with_animations/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String cacheKey = 'product_list';
ProductList? productListResponse;

class Services {
  static const String productUrl = "https://dummyjson.com/products";

  static Future<ProductList> fetchProductData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(cacheKey)) {
      await Future.delayed(const Duration(milliseconds: 500));
      final cache = jsonDecode(prefs.getString(cacheKey)!);
      final expiresAt = DateTime.parse(cache['expiresAt']);
      if (expiresAt.isAfter(DateTime.now())) {
        productListResponse =
            ProductList.fromJson(jsonDecode(cache['productList']));
        return productListResponse!;
      }
    }
    return _fetchFromNetwork(prefs);
  }

  static Future<ProductList> _fetchFromNetwork(SharedPreferences prefs) async {
    final response = await http.get(Uri.parse(productUrl));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final productList = ProductList.fromJson(decodedResponse);

      prefs.setString(
          cacheKey,
          jsonEncode({
            'expiresAt':
                DateTime.now().add(const Duration(hours: 1)).toString(),
            'productList': response.body
          }));

      productListResponse = productList;
      return productList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
