import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estok_app/entities/user.dart';


void main() {
  group('UserRepository', () {
    test('saveUser', () async {
      User user = User(
        id: 1,
        name: "Bruno Borges",
        email: "brunoborges@example.com",
        password: "password",
        telephone: "123456789",
        token: "token",
      );
      await UserRepository.instance.saveUser(user);
      User savedUser = await UserRepository.instance.getUser();
      expect(savedUser.id, equals(user.id));
      expect(savedUser.name, equals(user.name));
      expect(savedUser.email, equals(user.email));
      expect(savedUser.password, equals(user.password));
      expect(savedUser.telephone, equals(user.telephone));
      expect(savedUser.token, equals(user.token));
    });

    test('getUser', () async {
      User user = User(
        id: 1,
        name: "Bruno Borges",
        email: "brunoborges@example.com",
        password: "password",
        telephone: "123456789",
        token: "token",
      );
      await UserRepository.instance.saveUser(user);
      User savedUser = await UserRepository.instance.getUser();
      expect(savedUser.id, equals(user.id));
      expect(savedUser.name, equals(user.name));
      expect(savedUser.email, equals(user.email));
      expect(savedUser.password, equals(user.password));
      expect(savedUser.telephone, equals(user.telephone));
      expect(savedUser.token, equals(user.token));
    });

    test('saveUserPassword', () async {
      String password = "password";
      await UserRepository.instance.saveUserPassword(password);
      String savedPassword = await UserRepository.instance.getUserPassword();
      expect(savedPassword, equals(password));
    });

    test('getUserPassword', () async {
      String password = "password";
      await UserRepository.instance.saveUserPassword(password);
      String savedPassword = await UserRepository.instance.getUserPassword();
      expect(savedPassword, equals(password));
    });

    test('deleteSharedPrefs', () async {
      User user = User(
        id: 1,
        name: "Bruno Borges",
        email: "brunoborges@example.com",
        password: "password",
        telephone: "123456789",
        token: "token",
      );
      await UserRepository.instance.saveUser(user);
      await UserRepository.instance.deleteSharedPrefs();
      User savedUser = await UserRepository.instance.getUser();
      expect(savedUser, equals(null));
    });

    test('clearUserData', () async {
      User user = User(
        id: 1,
        name: "Bruno Borges",
        email: "brunoborges@example.com",
        password: "password",
        telephone: "123456789",
        token: "token",
      );
      await UserRepository.instance.saveUser(user);
      await UserRepository.instance.clearUserData();
      User savedUser = await UserRepository.instance.getUser();
      expect(savedUser, equals(null));
    });
  });
}