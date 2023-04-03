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
    String stockString = instance.getString("stock.prefs");

    if (stockString == null || stockString.isEmpty) {
      return [];
    }

    List<dynamic> stockJsonList = json.decode(stockString);
    if (stockJsonList == null) {
      return [];
    }
    List<Stock> stockList = stockJsonList.map((json) => Stock.fromJson(json)).toList();
    return stockList;
  }

  Future<void> clearStockData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('stock.prefs');
  }
}
