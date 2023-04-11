import 'package:estok_app/entities/stock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Stock", () {
    test("toJson() deve retornar um JSON válido", () {
      final stock = Stock(
        id: 1,
        stockDescription: "Stock description",
        stockTotalProductQuantity: 10.5,
        enterDate: DateTime(2022, 1, 1),
        validityDate: DateTime(2023, 1, 1),
        typeOfStock: "Type",
        stockStatus: "Status",
      );
      final json = stock.toJson();

      expect(json["id"], 1);
      expect(json["descricao"],"Stock description");
      expect(json["quantidade_total"], 10.5);
      expect(json["data_entrada"], "2022-01-01 00:00:00.000000");
      expect(json["data_validade"], "2023-01-01 00:00:00.000000");
      expect(json["tipo"], 'Type');
      expect(json["status_estoque"], "Status");
    });

    test("fromJson() deve retornar um objeto de Stock valido", () {
      final json = {
        "id": 1,
        "descricao": "Stock description",
        "quantidade_total": 10.5,
        "data_entrada": '2022-01-01 00:00:00.000000',
        "data_validade": '2023-01-01 00:00:00.000000',
        "tipo": "Type",
        "status_estoque": "Status",
      };
      final stock = Stock.fromJson(json);

      expect(stock.id, 1);
      expect(stock.stockDescription, "Stock description");
      expect(stock.stockTotalProductQuantity, 10.5);
      expect(stock.enterDate, DateTime(2022, 1, 1));
      expect(stock.validityDate, DateTime(2023, 1, 1));
      expect(stock.typeOfStock, "Type");
      expect(stock.stockStatus, "Status");
    });

    test("toJsonAdd() deve retornar um Json válido", () {
      final stock = Stock(
        stockDescription: "Stock description",
        stockTotalProductQuantity: 10.5,
        enterDate: DateTime(2022, 1, 1),
        validityDate: DateTime(2023, 1, 1),
        typeOfStock: 'Type',
      );
      final json = stock.toJsonAdd();

      expect(json["descricao"], "Stock description");
      expect(json["quantidade_total"], 10.5);
      expect(json["data_entrada"], "2022-01-01 00:00:00.000000");
      expect(json["data_validade"], "2023-01-01 00:00:00.000000");
      expect(json["tipo"], "Type");
      expect(json["status_estoque"], null);
    });

    test("toJsonUpdate() deve retornar um Json válido", () {
      final stock = Stock(
        id: 1,
        stockDescription: 'Stock description',
        stockTotalProductQuantity: 10.5,
        enterDate: DateTime(2022, 1, 1),
        validityDate: DateTime(2023, 1, 1),
        typeOfStock: "Type",
      );
      final json = stock.toJsonUpdate();

      expect(json["id"], 1);
      expect(json["descricao"], "Stock description");
      expect(json["quantidade_total"], 10.5);
      expect(json["data_entrada"], "2022-01-01 00:00:00.000000");
      expect(json["data_validade"], "2023-01-01 00:00:00.000000");
      expect(json["tipo"], "Type");
      expect(json["status_estoque"], null);
    });
  });
}
