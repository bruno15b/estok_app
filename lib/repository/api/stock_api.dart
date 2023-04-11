import 'dart:convert';
import 'package:estok_app/app/shared/constants.dart';
import 'package:estok_app/entities/stock.dart';
import '../local/user_repository.dart';
import '../../entities/user.dart';

import 'package:http/http.dart' as http;

class StockApi {

  final http.Client _client;
  final UserRepository _userRepository;

  static final StockApi instance = StockApi._(http.Client(),UserRepository.instance);

  StockApi._(this._client,this._userRepository);

  Future<List<Stock>> getAllStocks() async {
    List<Stock> stockList;
    try {
      User user = await _userRepository.getUser();
      //print("StockApi[getAllStocks]:---------- Entrou com Sucesso");
      String url = Constants.BASE_URL_API + "estoques/";

      String authorization = "Bearer ${user.token}";

      var response = await _client.get(url, headers: {"Content-Type": "application/json", "Authorization": authorization});

      if (response.statusCode == 200) {
       // print("StockApi[getAllStocks]:---------- Saiu com sucesso");
        var responseData = json.decode(utf8.decode(response.bodyBytes));

        stockList = (responseData["data"] as List)?.map((json) {
          return Stock.fromJson(json as Map<String, dynamic>);
        })?.toList();

        return stockList;
      } else {
        //print("StockApi[getAllStocks]:----------  Saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("Exception: failed to get stocks: $error");
      return null;
    }
  }

  postNewStock(Stock stock) async {
    try {
     // print("StockApi[postNewStock]:---------- Entrou");
      User user = await _userRepository.getUser();

     // print(stock.id);
     // print(user.token);

      var encodeString = stock.toJsonAdd();
      var encode = json.encode(encodeString);

     // print(encode);

      String url = Constants.BASE_URL_API + "estoques/";

      String authorization = "Bearer ${user.token}";

      var response = await _client.post(
        url,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
        body: encode,
      );

      if (response.statusCode == 200) {
       // print("StockApi[postNewStock]:----------  Saiu com sucesso");
        return stock;
      } else {
       // print("StockApi[postNewStock]:---------- Saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("Exception: failed add Stock: $error");
      return null;
    }
  }

  putStock(Stock stock) async {
    try {
     // print("StockApi[putStock]---------- Entrou");
      User user = await _userRepository.getUser();
      var encodeString = stock.toJsonUpdate();
      var encode = json.encode(encodeString);

      String url = Constants.BASE_URL_API + "estoques/";

      String authorization = "Bearer ${user.token}";

      var response = await _client.put(
        url,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
        body: encode,
      );

      if (response.statusCode == 200) {
       // print("StockApi[putStock]:---------- Saiu com Sucesso");
        return stock;
      } else {
       // print("StockApi[putStock]:---------- saiu com erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("Exception: failed add Stock: $error");
      return null;
    }
  }

  deleteStock(int stockId) async {
    try {
    //  print("StockApi[deleteStock]:---------- Entrou");
      User user = await _userRepository.getUser();
      String url = Constants.BASE_URL_API + "estoques/$stockId";
      String authorization = "Bearer ${user.token}";

      var response =
          await _client.delete(url, headers: {"Content-Type": "application/json", "Authorization": authorization});

      if (response.statusCode == 200) {
      //  print("StockApi[deleteStock]:---------- Saiu com sucesso");
        return stockId;
      } else {
       // print("StockApi[deleteStock]:---------- saiu com erro : ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("Exception: failed to delete stock: $error");
      return null;
    }
  }
}
