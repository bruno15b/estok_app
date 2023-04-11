import 'package:estok_app/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product", () {
    test("fromJson deve criar um Produto a partir de um objeto JSON", () {
      final json = {
        "id": 1,
        "estoque_id": 1,
        "nome": "Product A",
        "descricao": "This is product A",
        "imagem": "https://example.com/image.png",
        "valor_item": 10.0,
        "valor_unitario": 15.0,
        "quantidade": 20,
        "site": "https://example.com"
      };

      final product = Product.fromJson(json);

      expect(product.id, equals(1));
      expect(product.stockId, equals(1));
      expect(product.productName, equals("Product A"));
      expect(product.productDescription, equals("This is product A"));
      expect(product.productImageUrl, equals("https://example.com/image.png"));
      expect(product.productItemPrice, equals(10.0));
      expect(product.productUnitaryPrice, equals(15.0));
      expect(product.productQuantity, equals(20));
      expect(product.productUrlSite, equals("https://example.com"));
    });

    test("toJsonAdd deve criar um objeto JSON para adicionar um produto", () {
      final product = Product(
        productName: "Product A",
        productDescription: "This is product A",
        productItemPrice: 10.0,
        productUnitaryPrice: 15.0,
        productQuantity: 20,
        productUrlSite: "https://example.com",
      );

      final json = product.toJsonAdd();

      expect(json["nome"], equals("Product A"));
      expect(json["descricao"], equals("This is product A"));
      expect(json["imagem"], null);
      expect(json["valor_item"], equals(10.0));
      expect(json["valor_unitario"], equals(15.0));
      expect(json["quantidade"], equals(20));
      expect(json["site"], equals("https://example.com"));
    });

    test("toJsonUpdate deve criar um objeto JSON para atualizar um produto", () {
      final product = Product(
        id: 1,
        productName: "Product A",
        productDescription: "This is product A",
        productItemPrice: 10.0,
        productUnitaryPrice: 15.0,
        productQuantity: 20,
        productUrlSite: "https://example.com",
      );

      final json = product.toJsonUpdate();

      expect(json["id"], equals(1));
      expect(json["nome"], equals("Product A"));
      expect(json["descricao"], equals("This is product A"));
      expect(json["imagem"], null);
      expect(json["valor_item"], equals(10.0));
      expect(json["valor_unitario"], equals(15.0));
      expect(json["quantidade"], equals(20));
      expect(json["site"], equals("https://example.com"));
    });
  });
}
