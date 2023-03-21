import 'package:estok_app/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static final UserApi instance = UserApi._();

  UserApi._();

  Future<User> signIn(String email, String password) async {
    var encodeString = {
      "email": email,
      "senha": password,
    };

    var encode = json.encode(encodeString);
    String url = "http://54.90.203.92/auth/login";

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: encode);

    if (response.statusCode == 200) {
      var responseData = json.decode(utf8.decode(response.bodyBytes));

      User user = User.fromJson(responseData);
      return user;
    } else {
      return null;
    }
  }
}
