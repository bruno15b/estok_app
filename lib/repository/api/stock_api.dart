import 'dart:convert';
import 'package:estok_app/entities/stock.dart';
import 'package:http/http.dart' as http;

class StockApi {
  static final StockApi instance = StockApi._();

  StockApi._();

  Future<List<Stock>> getAllStocks(String userToken) async {
    List<Stock> stockList;

    try {
      String url = "http://54.90.203.92/estoques/";

      String authorization = "Bearer $userToken";

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });


      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));

        stockList = (responseData["data"] as List)?.map((json) {
          return Stock.fromJson(json as Map<String, dynamic>);
        })?.toList();

        return stockList;
      } else {
        print("StockApi[getAllStocks]: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed to get stocks: $error");
      return null;
    }
  }

  postNewStock(String userToken, Stock stock) async {

    try {
      var encodeString = stock.toJson();
      var encode = json.encode(encodeString);

      print(encode);

      String url = "http://54.90.203.92/estoques/";

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
        return stock;
      } else {
        print("StockApi[postNewStock]: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

  putStock(String userToken, Stock stock) async {

    try {
      var encodeString = stock.toJson();
      var encode = json.encode(encodeString);

      String url = "http://54.90.203.92/estoques/";

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
        return stock;
      } else {
        print("StockApi[putNewStock]: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("failed add Stock: $error");
      return null;
    }
  }

 deleteStock(String userToken, int stockId) async {
    try {
      String url = "http://54.90.203.92/estoques/$stockId";
      String authorization = "Bearer $userToken";

      var response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode == 200) {
        return stockId;
      } else {
        print("StockApi[deleteStock]: ${response.statusCode}");
        return false;
      }
    } on Exception catch (error) {
      print("failed to delete stock: $error");
      return false;
    }
  }

}
