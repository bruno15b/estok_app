import 'dart:convert';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:http/http.dart' as http;
import '../local/user_repository.dart';

class StockApi {
  static final StockApi instance = StockApi._();

  StockApi._();

  Future<List<Stock>> getAllStock(
      String userToken, void Function() renewTokenCallback) async {
    List<Stock> stockList;

    try {
      String url = "http://54.90.203.92/estoques/";

      String authorization = "Bearer $userToken";

      print("Dentro get All : $authorization");

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode != 200) {
        renewTokenCallback();
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));

      stockList = (responseData["data"] as List)?.map((json) {
        return Stock.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return stockList;
    } on Exception catch (error) {
      print("failed to get stocks: $error");
      return null;
    }
  }
}
