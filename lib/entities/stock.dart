import 'package:intl/intl.dart';

class Stock {
  int id;
  String stockDescription;
  double stockTotalProductQuantity;
  DateTime enterDate;
  DateTime validityDate;
  String typeOfStock;
  String stockStatus;

  static const String ID_FIELD = "id";
  static const String STOCK_DESCRIPTION_FIELD = "descricao";
  static const String TOTAL_STOCK_QUANTITY_FIELD = "quantidade_total";
  static const String ENTER_DATE_FIELD = "data_entrada";
  static const String VALIDITY_DATE_FIELD = "data_validade";
  static const String TYPE_OF_STOCK_FIELD = "tipo";
  static const String STOCK_STATUS_FIELD = "status_estoque";

  Stock({
    this.id,
    this.stockDescription,
    this.stockTotalProductQuantity,
    this.enterDate,
    this.validityDate,
    this.typeOfStock,
    this.stockStatus,
  });

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.ssssss');
    return <String, dynamic>{
      ID_FIELD: id,
      STOCK_DESCRIPTION_FIELD: stockDescription ,
      TOTAL_STOCK_QUANTITY_FIELD: stockTotalProductQuantity,
      ENTER_DATE_FIELD: enterDate != null ? dateFormat.format(enterDate) : null,
      VALIDITY_DATE_FIELD : validityDate != null ? dateFormat.format(validityDate) : null,
      TYPE_OF_STOCK_FIELD: typeOfStock,
      STOCK_STATUS_FIELD:stockStatus,
    };
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: (json[ID_FIELD] as num).toInt(),
      stockDescription: (json[STOCK_DESCRIPTION_FIELD] as String),
      stockTotalProductQuantity: (json[TOTAL_STOCK_QUANTITY_FIELD] as num).toDouble(),
      enterDate: DateTime.parse(json[ENTER_DATE_FIELD]),
      validityDate: DateTime.parse(json[VALIDITY_DATE_FIELD]),
      typeOfStock: (json[TYPE_OF_STOCK_FIELD] as String),
      stockStatus: (json[STOCK_STATUS_FIELD] as String),
    );
  }

  Map<String, dynamic> toJsonAdd() {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.ssssss');
    return <String, dynamic>{
      STOCK_DESCRIPTION_FIELD: stockDescription ,
      TOTAL_STOCK_QUANTITY_FIELD: stockTotalProductQuantity,
      ENTER_DATE_FIELD: enterDate != null ? dateFormat.format(enterDate) : null,
      VALIDITY_DATE_FIELD : validityDate != null ? dateFormat.format(validityDate) : null,
      TYPE_OF_STOCK_FIELD: typeOfStock,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.ssssss');
    return <String, dynamic>{
      ID_FIELD: id,
      STOCK_DESCRIPTION_FIELD: stockDescription ,
      TOTAL_STOCK_QUANTITY_FIELD: stockTotalProductQuantity,
      ENTER_DATE_FIELD: enterDate != null ? dateFormat.format(enterDate) : null,
      VALIDITY_DATE_FIELD : validityDate != null ? dateFormat.format(validityDate) : null,
      TYPE_OF_STOCK_FIELD: typeOfStock,
    };
  }
}
