import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
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

  Future<void> fetch(BuildContext context) async {
    print("entrou na api");
    this.futureStockList = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureStockList = StockApi.instance.getAllStock(await UserRepository.instance.getUserToken(),UserModel.of(context).renewToken);
    StockRepository.instance.saveStockList(await this.futureStockList);
    setState();
  }

}
