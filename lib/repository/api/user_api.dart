import 'package:estok_app/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static final UserApi instance = UserApi._();

  UserApi._();

  Future<User> signIn(String email, String password) async {
    try {
      var encodeString = {
        "email": email,
        "senha": password,
      };

      var encode = json.encode(encodeString);
      String url = "http://54.90.203.92/auth/login";

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: encode);

      if (response.statusCode != 200) {
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));

      User user = User.fromJson(responseData["data"]);

      return user;
    } catch (e) {
      print('Erro ao realizar login: $e');
      return null;
    }
  }

  renewToken(String email, String password) async {
    try {
      var encodeString = {
        "email": email,
        "senha": password,
      };

      print(encodeString);

      var encode = json.encode(encodeString);
      String url = "http://54.90.203.92/auth/login";

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: encode);

      print("dentro do renwCode: ${response.statusCode}");

      if (response.statusCode != 200) {
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));

      return responseData["data"]["token"];
    } catch (e) {
      print('Erro ao renovar token: $e');
      return null;
    }
  }

  Future<void> logout(String token) async {
    try {
      String url = "http://54.90.203.92/auth/logout";

      var response =
          await http.post(url, headers: {"Authorization": "Bearer $token"});

      if (response.statusCode != 200) {
        throw Exception('Erro ao realizar logout');
      } else {
        print("logout efetuado");
      }
    } catch (e) {
      print('Erro ao realizar logout: $e');
      throw e;
    }
  }
}
