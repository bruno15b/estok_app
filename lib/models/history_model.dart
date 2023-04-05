import 'package:estok_app/entities/history.dart';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/object_type_enum.dart';
import 'package:estok_app/enums/operation_type_enum.dart';
import 'package:estok_app/repository/local/history_repository.dart';
import 'package:estok_app/extensions/operation_type_extension.dart';
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
  void saveHistory(ObjectTypeEnum objectType, String objectName, String operationType) async {

    final history = History(
      date: DateTime.now().toLocal(),
      objectType: objectType.toString().split('.').last,
      objectName: objectName,
      operationType: operationType,
    );

    await HistoryRepository.instance.save(history);
  }

  void saveHistoryOnInsert({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(ObjectTypeEnum.ESTOQUE, stock.stockDescription, OperationTypeEnum.INSERCAO.stringValue);
    } else if (product != null) {
      saveHistory(ObjectTypeEnum.PRODUTO, product.productName, OperationTypeEnum.INSERCAO.stringValue);
    }
  }

  void saveHistoryOnUpdate({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(ObjectTypeEnum.ESTOQUE, stock.stockDescription, OperationTypeEnum.REMOCAO.stringValue);
    } else if (product != null) {
      saveHistory(ObjectTypeEnum.PRODUTO, product.productName, OperationTypeEnum.ATUALIZACAO.stringValue);
    }
  }

  void saveHistoryOnDelete({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(ObjectTypeEnum.ESTOQUE, stock.stockDescription, OperationTypeEnum.REMOCAO.stringValue);
    } else if (product != null) {
      saveHistory(ObjectTypeEnum.PRODUTO, product.productName, OperationTypeEnum.REMOCAO.stringValue);
    }
  }

  Future<void> getAllHistory() async {
    historyListFuture = HistoryRepository.instance.getAll();
  }
}
