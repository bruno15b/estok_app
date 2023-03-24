class Stock {
  int id;
  String description;
  double totalProductQuantity;
  DateTime enterDate;
  DateTime validityDate;
  String typeOfStock;
  String stockStatus;

  static const String ID_FIELD = "id";
  static const String DESCRIPTION_FIELD = "descricao";
  static const String TOTAL_STOCK_QUANTITY_FIELD = "quantidade_total";
  static const String ENTER_DATE_FIELD = "data_entrada";
  static const String VALIDITY_DATE_FIELD = "data_validade";
  static const String TYPE_OF_STOCK_FIELD = "tipo";
  static const String STOCK_STATUS_FIELD = "status_estoque";

  Stock({
    this.id,
    this.description,
    this.totalProductQuantity,
    this.enterDate,
    this.validityDate,
    this.typeOfStock,
    this.stockStatus,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: (json[ID_FIELD] as num).toInt(),
      description: (json[DESCRIPTION_FIELD] as String),
      totalProductQuantity: (json[TOTAL_STOCK_QUANTITY_FIELD] as num).toDouble(),
      enterDate: DateTime.parse(json[ENTER_DATE_FIELD]),
      validityDate: DateTime.parse(json[VALIDITY_DATE_FIELD]),
      typeOfStock: (json[TYPE_OF_STOCK_FIELD] as String),
      stockStatus: (json[STOCK_STATUS_FIELD] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ID_FIELD: id,
      DESCRIPTION_FIELD: description,
      TOTAL_STOCK_QUANTITY_FIELD: totalProductQuantity,
      ENTER_DATE_FIELD: enterDate.toIso8601String(),
      VALIDITY_DATE_FIELD : validityDate.toIso8601String(),
      TYPE_OF_STOCK_FIELD: typeOfStock,
      STOCK_STATUS_FIELD: stockStatus,
    };
  }
}
