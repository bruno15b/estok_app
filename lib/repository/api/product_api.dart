import 'dart:convert';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static final ProductApi instance = ProductApi._();

  ProductApi._();

  Future<List<Product>> getAllProducts(String userToken,int stockId) async {
    List<Product> productList;

    try {

      print("ProductApi[getAllProduct]:---------- Entrou");
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

        print("ProductApi[getAllProduct]:---------- Saiu com Sucesso");

        return productList;
      } else {
        print("ProductApi[getAllProduct]:----------  Saiu com erro: ${response.statusCode}");
        return null;
      }

    } on Exception catch (error) {
      print("failed to get products: $error");
      return null;
    }
  }

  postNewProduct(String userToken, Product product) async {

    try {
      print("ProductApi[postNewProduct]:---------- Entrou");
      var encodeString = product.toJsonAdd();
      var encode = json.encode(encodeString);


      String url = "http://54.90.203.92/estoques/${product.stockId}/produtos/";


      String authorization = "Bearer $userToken";

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authorization
        },
        body: encode,
      );

      if (response.statusCode == 200) {

        print("ProductApi[postNewProduct]:---------- Saiu com Sucesso");
        return product;
      } else {
        print("ProductApi[postNewProduct]---------- Saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

    putProduct(String userToken, Product product) async {

    try {
      print("ProductApi[putProduct]:----------  Entrou");
      var encodeString = product.toJsonUpdate();
      var encode = json.encode(encodeString);

      String url = "http://54.90.203.92/estoques/${product.stockId}/produtos/";

      String authorization = "Bearer $userToken";

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authorization
        },
        body: encode,
      );


      if (response.statusCode == 200) {
        print("ProductApi[putProduct]:---------- Saiu com sucesso");
        return product;
      } else {
        print("ProductApi[putNewProduct]---------- saiu com Erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

  deleteProduct(String userToken, Product product) async {
    try {
      print("ProductApi[deleteProduct]:---------- Entrou");
      String url = "http://54.90.203.92/estoques/${product.stockId}/produtos/${product.id}";
      String authorization = "Bearer $userToken";

      var response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode == 200) {
        print("ProductApi[deleteProduct]:----------  Saiu com sucesso");
        return true;
      } else {
        print("ProductApi[deleteProduct]:---------- Saiu com erro: ${response.statusCode}");
        return false;
      }
    } on Exception catch (error) {
      print("failed to delete product: $error");
      return null;
    }
  }

}
