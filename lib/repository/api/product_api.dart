import 'dart:convert';
import 'package:estok_app/app/shared/constants.dart';
import 'package:estok_app/entities/product.dart';
import 'package:meta/meta.dart';
import '../local/user_repository.dart';
import '../../entities/user.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  http.Client _client;
  UserRepository _userRepository;

  static ProductApi instance = ProductApi._(http.Client(), UserRepository.instance);

  ProductApi._(this._client, this._userRepository);

  @visibleForTesting
  static ProductApi forTestOnly(http.Client client, UserRepository userRepository) {
    return ProductApi._(client, userRepository);
  }

  Future<List<Product>> getAllProducts(int stockId) async {
    List<Product> productList;

    User user = await _userRepository.getUser();

    try {
      //print("ProductApi[getAllProduct]:---------- Entrou");
      final String url = Constants.BASE_URL_API + "estoques/$stockId/produtos/";

      final String authorization = "Bearer ${user.token}";

      var response =
          await _client.get(url, headers: {"Content-Type": "application/json", "Authorization": authorization});

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));

        productList = (responseData["data"] as List)?.map((json) {
          return Product.fromJson(json as Map<String, dynamic>);
        })?.toList();

        //("ProductApi[getAllProduct]:---------- Saiu com Sucesso");

        return productList;
      } else {
        //print("ProductApi[getAllProduct]:----------  Saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed to get products: $error");
      return null;
    }
  }

  postNewProduct(Product product) async {
    try {
      //print("ProductApi[postNewProduct]:---------- Entrou");

      User user = await _userRepository.getUser();
      var encodeString = product.toJsonAdd();
      var encode = json.encode(encodeString);

      String url = Constants.BASE_URL_API + "estoques/${product.stockId}/produtos/";

      String authorization = "Bearer ${user.token}";

      var response = await _client.post(
        url,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
        body: encode,
      );

      if (response.statusCode == 200) {
        //print("ProductApi[postNewProduct]:---------- Saiu com Sucesso");
        return response.statusCode;
      } else {
      //  print("ProductApi[postNewProduct]---------- Saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

  putProduct(Product product) async {
    try {
      //print("ProductApi[putProduct]:----------  Entrou");
      final user = await _userRepository.getUser();

      var encodeString = product.toJsonUpdate();
      var encode = json.encode(encodeString);

      String url = Constants.BASE_URL_API + "estoques/${product.stockId}/produtos/";

      String authorization = "Bearer ${user.token}";

      var response = await _client.put(
        url,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
        body: encode,
      );

      if (response.statusCode == 200) {
       // print("ProductApi[putProduct]:---------- Saiu com sucesso");
        return response.statusCode;
      } else {
       // print("ProductApi[putNewProduct]---------- saiu com Erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

  deleteProduct(Product product) async {
    try {
      User user = await _userRepository.getUser();
    //  print("ProductApi[deleteProduct]:---------- Entrou");
      String url = Constants.BASE_URL_API + "estoques/${product.stockId}/produtos/${product.id}";
      String authorization = "Bearer ${user.token}";

      var response =
          await _client.delete(url, headers: {"Content-Type": "application/json", "Authorization": authorization});

      if (response.statusCode == 200) {
     //   print("ProductApi[deleteProduct]:----------  Saiu com sucesso");
        return true;
      } else {
     //   print("ProductApi[deleteProduct]:---------- Saiu com erro: ${response.statusCode}");
        return false;
      }
    } on Exception catch (error) {
      print("Exception: failed to delete product: $error");
      return null;
    }
  }
}
