import 'dart:convert';
import 'package:estok_app/entities/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static final ProductApi instance = ProductApi._();

  ProductApi._();

  Future<List<Product>> getAllProducts(int stockId, String userToken) async {
    List<Product> productList;

    try {
      final String url = "http://54.90.203.92/estoques/$stockId/produtos/";

      final String authorization = "Bearer $userToken";


      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));

        productList = (responseData["data"] as List)?.map((json) {
          return Product.fromJson(json as Map<String, dynamic>);
        })?.toList();

        return productList;
      } else {
        print("ProductApi: ${response.statusCode}");
        return null;
      }

    } on Exception catch (error) {
      print("failed to get products: $error");
      return null;
    }
  }
}
