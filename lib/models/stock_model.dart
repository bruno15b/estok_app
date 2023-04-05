import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/stock_status_enum.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/extensions/stock_status_extension.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class StockModel extends Model {
  Future<List<Stock>> futureStockList;
  String selectedStockType = "CAIXA";
  final dateFormatString = "dd/MM/yyyy";
  Stock selectedStock;
  String selectedStockStatusText;
  Color selectedStockStatusColor;

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
    selectedStock = stock;
  }

  Future<void> updateStockTotalProductQuantity(double stockQuantity) async {
    selectedStock.stockTotalProductQuantity = stockQuantity;
    await StockApi.instance.putStock(selectedStock);
  }

  void updateOpenStockStatus() {
    print(selectedStock.stockTotalProductQuantity);
    StockStatusEnum stockStatus = StockStatusExtension.fromStockQuantity(selectedStock.stockTotalProductQuantity);
    selectedStockStatusColor = stockStatus.colorValue;
    selectedStockStatusText= stockStatus.stringValue;
    setState();
  }

  List<Stock> filterStockByStatus(List<Stock> stocks, String status) {
    if (status == StockStatusEnum.TODOS.stringValue) {
      return stocks;
    } else {
      return stocks.where((stockItem) => stockItem.stockStatus == status).toList();
    }
  }

  String onChangeTypeOfStock(String newType) {
    selectedStockType = newType;
    setState();
    return selectedStockType;
  }

  DateTime formatStringToDate(String dateString) {
    return DateFormat(dateFormatString).parse(dateString);
  }

  String formatDateToString(DateTime date) {
    return DateFormat(dateFormatString).format(date);
  }
}
