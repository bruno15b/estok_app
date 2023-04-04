import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/stock_status.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class StockModel extends Model {
  Future<List<Stock>> futureStockList;
  String typeOfStock = "CAIXA";
  final dateTypeFormat = "dd/MM/yyyy";
  Stock openStock;
  String textStockStatusReplacer;
  Color colorStockStatusReplacer;

  static StockModel of(BuildContext context) {
    return ScopedModel.of<StockModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchAllStocks() async {
    setState();
    futureStockList = StockApi.instance.getAllStocks();
    setState();
  }


  Future<void> createNewStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    var response = await StockApi.instance.postNewStock(stock);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao criar novo Estoque!");
    }
  }

  Future<void> updateStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    var response = await StockApi.instance.putStock(stock);
    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao editar estoque!");
    }
  }

  deleteStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    var response = await StockApi.instance.deleteStock(stock.id);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao deletar estoque!");
    }
  }

  void saveOpenStock(Stock stock) {
    openStock = stock;
  }

  Future<void> updateStockTotalProductQuantity(double stockQuantity) async {
    openStock.stockTotalProductQuantity = stockQuantity;
    await StockApi.instance.putStock(openStock);
  }

  void updateOpenStockStatus() {
    print(openStock.stockTotalProductQuantity);
    StockStatus stockStatus = StockStatusExtension.fromStockQuantity(openStock.stockTotalProductQuantity);
    colorStockStatusReplacer = stockStatus.colorValue;
    textStockStatusReplacer = stockStatus.stringValue;
    setState();
  }

  List<Stock> filterStockByStatus(List<Stock> stocks, String status) {
    if (status == StockStatus.TODOS.stringValue) {
      return stocks;
    } else {
      return stocks.where((stockItem) => stockItem.stockStatus == status).toList();
    }
  }

  String onChangeTypeOfStock(String newType) {
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
