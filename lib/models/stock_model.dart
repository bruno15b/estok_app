import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class StockModel extends Model {
  Future<List<Stock>> futureStockList;
  double stockQuantity;
  String typeOfStock = "CAIXA";
  final dateTypeFormat = "dd/MM/yyyy";


  static StockModel of(BuildContext context) {
    return ScopedModel.of<StockModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<List<Stock>> fetchStocks() async {
    final userToken = await UserRepository.instance.getUserToken();
    List<Stock> stockList = await StockApi.instance.getAllStocks(userToken);
    StockRepository.instance.saveStockList(stockList);

    this.futureStockList = Future.value(stockList);
    setState();

    return this.futureStockList;
  }


 Future<void> createNewStock(Stock stock ,{VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();

    var response = await StockApi.instance.postNewStock(userToken, stock);

    if (response!= null){
      onSuccess();
      await fetchStocks();
    }else{
      onFail("Erro ao criar novo Estoque!");
    }

  }

 Future<void> updateStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await StockApi.instance.putStock(userToken, stock);
    if (response!= null){
      onSuccess();
      await fetchStocks();
    }else{
      onFail("Erro ao editar estoque!");
    }

  }

   deleteStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await StockApi.instance.deleteStock(userToken, stock.id);

    if (response != null){
      onSuccess();
      await fetchStocks();
    }else{
      onFail("Erro ao deletar estoque!");
    }

  }

  List<Stock> filterStockByStatus(List<Stock> stocks, String status) {
    if (status == "TODOS") {
      return stocks;
    } else {
      return stocks
          .where((stockItem) => stockItem.stockStatus == status)
          .toList();
    }
  }

  String onChangeTypeOfStock(String newType){
    typeOfStock = newType;
    setState();
    return typeOfStock;
  }


  DateTime formatStringToDate(String dateString) {
    return DateFormat(dateTypeFormat).parse(dateString);
  }

  String formatDateToString(DateTime date) {
    return DateFormat(dateTypeFormat).format(date);
  }

}
