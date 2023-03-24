class Product {
  int id;
  int stockId;
  String productName;
  String productDescription;
  String productImageUrl;
  double productItemPrice;
  double productUnitaryPrice;
  int productQuantity;
  String urlSite;

  static const String ID_FIELD = "id";
  static const String STOCK_ID_FIELD = "estoque_id";
  static const String NAME_PRODUCT_FIELD = "nome";
  static const String PRODUCT_DESCRIPTION_FIELD = "descricao";
  static const String PRODUCT_IMAGE_URL_FIELD = "imagem";
  static const String ITEM_PRICE_FIELD = "valor_item";
  static const String UNITARY_PRICE_FIELD = "valor_unitario";
  static const String PRODUCT_QUANTITY_FIELD = "quantidade";
  static const String URL_SITE_FIELD = "site";

  Product({
    this.id,
    this.stockId,
    this.productName,
    this.productDescription,
    this.productImageUrl,
    this.productItemPrice,
    this.productUnitaryPrice,
    this.productQuantity,
    this.urlSite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json[ID_FIELD] as num).toInt(),
      stockId: (json[STOCK_ID_FIELD] as num).toInt(),
      productName: (json[NAME_PRODUCT_FIELD] as String),
      productDescription: (json[PRODUCT_DESCRIPTION_FIELD] as String),
      productImageUrl: (json[PRODUCT_IMAGE_URL_FIELD] as String),
      productItemPrice: (json[ITEM_PRICE_FIELD] as num).toDouble(),
      productUnitaryPrice: (json[UNITARY_PRICE_FIELD] as num).toDouble(),
      productQuantity: (json[PRODUCT_QUANTITY_FIELD] as num).toInt(),
      urlSite: (json[URL_SITE_FIELD] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ID_FIELD: id,
      STOCK_ID_FIELD: stockId,
      NAME_PRODUCT_FIELD: productName,
      PRODUCT_DESCRIPTION_FIELD: productDescription,
      PRODUCT_IMAGE_URL_FIELD: productImageUrl,
      ITEM_PRICE_FIELD: productItemPrice,
      UNITARY_PRICE_FIELD: productUnitaryPrice
    };
  }
}
