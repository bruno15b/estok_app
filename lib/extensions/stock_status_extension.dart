import 'dart:ui';
import 'package:estok_app/enums/stock_status_enum.dart';
import 'package:flutter/material.dart';

extension StockStatusExtension on StockStatusEnum {
  String get stringValue {
    switch (this) {
      case StockStatusEnum.EM_ESTOQUE:
        return "EM ESTOQUE";
      case StockStatusEnum.EM_FALTA:
        return "EM FALTA";
      case StockStatusEnum.EM_AVISO:
        return "EM AVISO";
      case StockStatusEnum.TODOS:
        return "TODOS";
      default:
        return "";
    }
  }

  Color get colorValue {
    switch (this) {
      case StockStatusEnum.EM_ESTOQUE:
        return Color(0xFF3AA637);
      case StockStatusEnum.EM_FALTA:
        return Color(0xFFA63737);
      case StockStatusEnum.EM_AVISO:
        return Color(0XFFDCC707);
      default:
        return Colors.black;
    }
  }

  static StockStatusEnum fromStockQuantity(double stockTotalQuantity) {
    if (stockTotalQuantity > 5) {
      return StockStatusEnum.EM_ESTOQUE;
    } else if (stockTotalQuantity == 0) {
      return StockStatusEnum.EM_FALTA;
    } else {
      return StockStatusEnum.EM_AVISO;
    }
  }
}