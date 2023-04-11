
import 'package:estok_app/entities/history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("History", () {
    test("fromJson deve retornar um objeto de Historico válido", () {
      final json = {
        "id": 1,
        "operationType": "CREATE",
        "entityType": "USER",
        "objectName": "John Doe",
        "dateTimeOperation": "2022-04-10T10:00:00Z",
        "operationCode": "12345"
      };

      final history = History.fromJson(json);

      expect(history.id, json["id"]);
      expect(history.operationType, json["operationType"]);
      expect(history.entityType, json["entityType"]);
      expect(history.objectName, json["objectName"]);
      expect(history.date, DateTime.parse(json["dateTimeOperation"]));
      expect(history.operationCode, json["operationCode"]);
    });

    test("toJson deve retornar um Map<String, dynamic> object", () {
      final history = History(
        id: 1,
        operationType: "CREATE",
        entityType: "USER",
        objectName: "John Doe",
        date: DateTime(2022, 4, 10, 10, 0, 0),
        operationCode: "12345",
      );

      final json = history.toJson();

      expect(json["id"], history.id);
      expect(json["operationType"], history.operationType);
      expect(json["entityType"], history.entityType);
      expect(json["objectName"], history.objectName);
      expect(json["dateTimeOperation"], history.date.toIso8601String());
      expect(json["operationCode"], history.operationCode);
    });
  });
}