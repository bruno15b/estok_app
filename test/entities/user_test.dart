import 'package:estok_app/entities/user.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("User", () {
    test("toJson() deve retornar um Json válido", () {
      final user = User(
        id: 1,
        name: "Bruno",
        email: "brunoborges@test.com",
        password: "123456",
        telephone: "555-5555",
        token: "abcdefg",
      );
      final json = user.toJson();
      expect(json["id"], 1);
      expect(json["nome"], "Bruno");
      expect(json["email"], "brunoborges@test.com");
      expect(json["senha"], "123456");
      expect(json["telefone"], "555-5555");
      expect(json["token"], "abcdefg");
    });

    test('fromJson() deve retornar um objeto User válido', () {
      final json = {
        "id": 1,
        "nome": "Bruno",
        "email": "brunoborges@test.com",
        "senha": "123456",
        "telefone": "555-5555",
        "token": "abcdefg",
      };
      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, "Bruno");
      expect(user.email, "brunoborges@test.com");
      expect(user.password, "123456");
      expect(user.telephone, "555-5555");
      expect(user.token, "abcdefg");
    });
  });
}