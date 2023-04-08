import '../stock_type_enum.dart';

extension StockTypeEnumExtension on StockTypeEnum {
  String get stringValue {
    switch (this) {
      case StockTypeEnum.CAIXA:
        return 'CAIXA';
      case StockTypeEnum.GRADE:
        return 'GRADE';
      case StockTypeEnum.PACOTE:
        return 'PACOTE';
      default:
        return 'Not Defined In Extension';
    }
  }
}
