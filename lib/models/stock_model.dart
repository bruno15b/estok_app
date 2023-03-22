import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockModel extends Model {

  Future<List<Stock>> futureStockList;

  static StockModel of(BuildContext context) {
    return ScopedModel.of<StockModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetch() async{
    this.futureStockList = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureStockList = StockApi.instance.getAll();
    setState();
  }

}