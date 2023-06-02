import 'dart:convert';
import 'package:app_with_animations/model/product_model.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String productUrl = "https://dummyjson.com/products";
  static Future<ProductList> fetchProductData() async {
    final response = await http.get(Uri.parse(productUrl));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final productList = ProductList.fromJson(decodedResponse);
      return productList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
