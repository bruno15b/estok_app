import 'dart:convert';
import 'package:estok_app/entities/product.dart';
import 'package:http/http.dart' as http;


class ProductApi {
  static final ProductApi instance = ProductApi._();

  ProductApi._();

  Future<List<Product>> getAllProducts(int stockId,
      String userToken, void Function() renewTokenCallback) async {
    List<Product> productList;

    try {
      final String url = "http://54.90.203.92/estoques/$stockId/produtos/";

     final String authorization = "Bearer $userToken";

      print("Dentro GetAllProduct : $authorization");

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });



      print(response.statusCode);

      if (response.statusCode != 200) {
        print("response.statusCode ");
        renewTokenCallback();
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));

      print(responseData);

      productList = (responseData["data"] as List)?.map((json) {
        return Product.fromJson(json as Map<String, dynamic>);
      })?.toList();

      print(productList.toList());

      return productList;

    } on Exception catch (error) {
      print("failed to get products: $error");
      return null;
    }
  }
}
