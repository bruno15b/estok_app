import 'package:flutter/material.dart';

enum StockStatus {
  EM_ESTOQUE,
  EM_FALTA,
  EM_AVISO,
  TODOS
}

extension StockStatusExtension on StockStatus {
  String get stringValue {
    switch (this) {
      case StockStatus.EM_ESTOQUE:
        return "EM ESTOQUE";
      case StockStatus.EM_FALTA:
        return "EM FALTA";
      case StockStatus.EM_AVISO:
        return "EM AVISO";
        case StockStatus.TODOS:
          return "TODOS";
      default:
        return "";
    }
  }

  Color get colorValue {
    switch (this) {
      case StockStatus.EM_ESTOQUE:
        return Color(0xFF3AA637);
      case StockStatus.EM_FALTA:
        return Color(0xFFA63737);
      case StockStatus.EM_AVISO:
        return Color(0XFFDCC707);
      default:
        return Colors.black;
    }
  }

  static StockStatus fromStockQuantity(double stockTotalQuantity) {
    if (stockTotalQuantity > 5) {
      return StockStatus.EM_ESTOQUE;
    } else if (stockTotalQuantity == 0) {
      return StockStatus.EM_FALTA;
    } else {
      return StockStatus.EM_AVISO;
    }
  }
}