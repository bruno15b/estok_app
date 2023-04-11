class Product {
  int id;
  int stockId;
  String productName;
  String productDescription;
  String productImageUrl;
  double productItemPrice;
  double productUnitaryPrice;
  int productQuantity;
  String productUrlSite;

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
    this.productUrlSite,
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
      productUrlSite: (json[URL_SITE_FIELD] as String),
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return <String, dynamic>{
      NAME_PRODUCT_FIELD: productName,
      PRODUCT_DESCRIPTION_FIELD: productDescription,
      PRODUCT_IMAGE_URL_FIELD: productImageUrl,
      ITEM_PRICE_FIELD: productItemPrice,
      UNITARY_PRICE_FIELD: productUnitaryPrice,
      PRODUCT_QUANTITY_FIELD: productQuantity,
      URL_SITE_FIELD: productUrlSite,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return <String, dynamic>{
      ID_FIELD: id,
      NAME_PRODUCT_FIELD: productName,
      PRODUCT_DESCRIPTION_FIELD: productDescription,
      PRODUCT_IMAGE_URL_FIELD: productImageUrl,
      ITEM_PRICE_FIELD: productItemPrice,
      UNITARY_PRICE_FIELD: productUnitaryPrice,
      PRODUCT_QUANTITY_FIELD: productQuantity,
      URL_SITE_FIELD: productUrlSite,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, stockId: $stockId, productName: $productName, productDescription: $productDescription, productImageUrl: $productImageUrl, productItemPrice: $productItemPrice, productUnitaryPrice: $productUnitaryPrice, productQuantity: $productQuantity, productUrlSite: $productUrlSite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          stockId == other.stockId &&
          productName == other.productName &&
          productDescription == other.productDescription &&
          productImageUrl == other.productImageUrl &&
          productItemPrice == other.productItemPrice &&
          productUnitaryPrice == other.productUnitaryPrice &&
          productQuantity == other.productQuantity &&
          productUrlSite == other.productUrlSite;

  @override
  int get hashCode =>
      id.hashCode ^
      stockId.hashCode ^
      productName.hashCode ^
      productDescription.hashCode ^
      productImageUrl.hashCode ^
      productItemPrice.hashCode ^
      productUnitaryPrice.hashCode ^
      productQuantity.hashCode ^
      productUrlSite.hashCode;
}
