import 'dart:convert';
import 'package:estok_app/entities/stock.dart';
import 'package:http/http.dart' as http;


class StockApi {
  static final StockApi instance = StockApi._();

  StockApi._();

  Future<List<Stock>> getAllStocks(
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
        print("StockApi: ${response.statusCode}");
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
