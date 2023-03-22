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

  Future<List<Stock>> getAll() async {
    List<Stock> stockList;
    try {
      String url = "http://54.90.203.92/estoques/";
      User user = await UserRepository.instance.getUser();
      await UserRepository.instance.saveUser(user);
      String authorization = "Bearer ${user.token}";

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode == 403) {

        user = await UserApi.instance.signIn(await UserRepository.instance.getUserEmail(), await UserRepository.instance.getUserPassword());
        await UserRepository.instance.saveUser(user);

        return await StockRepository.instance.getStockList();

      }else if(response.statusCode != 200) {
        return null ;
      }


      var responseData = json.decode(utf8.decode(response.bodyBytes));

      stockList = (responseData["data"] as List)?.map((json) {
        return Stock.fromJson(json as Map<String, dynamic>);
      })?.toList();

      await StockRepository.instance.saveStockList(stockList);

      return stockList;
    } on Exception catch (error) {
      print(error);
      return null;
    }
  }
}
