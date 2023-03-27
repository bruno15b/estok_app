import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class StockModel extends Model {
  Future<List<Stock>> futureStockList;
  String typeOfStock = "CAIXA";
  final dateTypeFormat = "dd/MM/yyyy";


  static StockModel of(BuildContext context) {
    return ScopedModel.of<StockModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchStocks() async {
    this.futureStockList =
        Future.delayed(Duration(seconds: Duration.millisecondsPerDay));

    setState();

    final userToken = await UserRepository.instance.getUserToken();
    this.futureStockList = StockApi.instance.getAllStocks(userToken);
    StockRepository.instance.saveStockList(await this.futureStockList);

    setState();
  }

 void  createNewStock(Stock stock ,{VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();

    var response = await StockApi.instance.postNewStock(userToken, stock);

    if (response!= null){
      onSuccess();
      fetchStocks();
    }else{
      onFail("Erro ao criar novo Estoque!");
    }

  }

 void updateStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await StockApi.instance.putStock(userToken, stock);
    if (response!= null){
      onSuccess();
      fetchStocks();
    }else{
      onFail("Erro ao editar estoque!");
    }

  }

  void deleteStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await StockApi.instance.deleteStock(userToken, stock.id);

    if (response!= null){
      onSuccess();
      fetchStocks();
    }else{
      onFail("Erro ao deletar estoque!");
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
