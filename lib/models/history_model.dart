import 'package:estok_app/entities/history.dart';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/entity_type_enum.dart';
import 'package:estok_app/enums/operation_type_enum.dart';
import 'package:estok_app/repository/local/history_repository.dart';
import 'package:estok_app/enums/extensions/operation_type_enum_extension.dart';
import 'package:estok_app/enums/extensions/entity_type_enum_extension.dart';
import 'package:estok_app/utils/string_util.dart';
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
  void saveHistory(String entityType, String objectName, String operationType, int stockId) async {
    final history = History(
      date: DateTime.now().toLocal(),
      entityType: entityType + (stockId != null ? " - EstoqueID: $stockId": " -- Novo"),
      objectName: objectName,
      operationType: operationType,
      operationCode: StringUtil.generateRandomString(),
    );

    await HistoryRepository.instance.save(history);
  }

  void saveHistoryOnInsert({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(EntityTypeEnum.ESTOQUE.stringValue, stock.stockDescription, OperationTypeEnum.INSERCAO.stringValue,stock.id);
    } else if (product != null) {
      saveHistory(EntityTypeEnum.PRODUTO.stringValue, product.productName, OperationTypeEnum.INSERCAO.stringValue,product.stockId);
    }
  }

  void saveHistoryOnUpdate({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(EntityTypeEnum.ESTOQUE.stringValue, stock.stockDescription, OperationTypeEnum.ATUALIZACAO.stringValue,stock.id);
    } else if (product != null) {
      saveHistory(EntityTypeEnum.PRODUTO.stringValue, product.productName, OperationTypeEnum.ATUALIZACAO.stringValue,product.stockId);
    }
  }

  void saveHistoryOnDelete({Stock stock, Product product}) async {
    if (stock != null) {
      saveHistory(EntityTypeEnum.ESTOQUE.stringValue, stock.stockDescription, OperationTypeEnum.REMOCAO.stringValue,stock.id);
    } else if (product != null) {
      saveHistory(EntityTypeEnum.PRODUTO.stringValue, product.productName, OperationTypeEnum.REMOCAO.stringValue,product.stockId);
    }
  }

  Future<void> getAllHistory() async {
    setState();
     historyListFuture = HistoryRepository.instance.getAll();
    setState();
  }
}
