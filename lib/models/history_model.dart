import 'package:estok_app/entities/history.dart';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/local/history_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoryModel extends Model {
  Future<List<History>> historyListFuture = Future.value([]);

  static HistoryModel of(BuildContext context) {
    return ScopedModel.of<HistoryModel>(context);
  }

  void setState() {
    notifyListeners();
  }

  void saveHistory(String objectType, String objectName, String operationType) async {
    final history = History(
      date: DateTime.now().toLocal(),
      objectType: objectType,
      objectName: objectName,
      operationType: operationType,
    );

    print(history.toJson());

    await HistoryRepository.instance.save(history);
  }

  void saveHistoryOnInsert({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory("ESTOQUE", stock.stockDescription, "INSERÇÃO");
    } else if (product != null) {
      saveHistory("PRODUTO", product.productName, "INSERÇÃO");
    }
  }

  void saveHistoryOnUpdate({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory("ESTOQUE", stock.stockDescription, "ATUALIZAÇÃO");
    } else if (product != null) {
      saveHistory("PRODUTO", product.productName, "ATUALIZAÇÃO");
    }
  }

  void saveHistoryOnDelete({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory("ESTOQUE", stock.stockDescription, "REMOÇÃO");
    } else if (product != null) {
      saveHistory("PRODUTO", product.productName, "REMOÇÃO");
    }
  }

  Future<void> getAllHistory() async {
    historyListFuture = HistoryRepository.instance.getAll();
  }
}
