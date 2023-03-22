import 'dart:convert';
import 'package:estok_app/entities/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockRepository {
  static final StockRepository instance = StockRepository._();

  StockRepository._();

  Future<void> saveStockList(List<Stock> stockList) async {
    String stockString = json.encode(stockList);
    var instance = await SharedPreferences.getInstance();
    await instance.setString("stock.prefs", stockString);
  }

  Future<List<Stock>> getStockList() async {
    var instance = await SharedPreferences.getInstance();
    String stockString = await instance.getString("stock.prefs");
    if (stockString == null || stockString.isEmpty) {
      return null;
    }
    List<dynamic> stockJsonList = json.decode(stockString);
    List<Stock> stockList =
    stockJsonList.map((json) => Stock.fromJson(json)).toList();
    return stockList;
  }
}