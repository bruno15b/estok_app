import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';

class ServerSyncUtil {

  static Future<void> updateStocksWithServer(BuildContext context, Product product) async {
    Message.alertDialogLoading(context);
    try {
      await Future.delayed(Duration(milliseconds: 200));
      await ProductModel.of(context).sumProductsTotalValue();
      double totalStock = await ProductModel.of(context).sumProductsTotalQuantity();
      await Future.delayed(Duration(milliseconds: 200));
      await StockModel.of(context).updateStockTotalProductQuantity(totalStock);
      StockModel.of(context).updateSelectedStockStatus();
      await Future.delayed(Duration(milliseconds: 200));
      await StockModel.of(context).fetchAllStocks();
    } catch (e) {
      print(e);
    } finally {
      Navigator.of(context).pop();
    }
  }

}
