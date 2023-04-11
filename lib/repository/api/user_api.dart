import 'package:estok_app/app/shared/constants.dart';
import 'package:estok_app/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  final http.Client _client;


  static final UserApi instance = UserApi._(http.Client());

  UserApi._(this._client);
  Future<User> signIn(String email, String password) async {
    try {

      var encodeString = {
        "email": email,
        "senha": password,
      };

      var encode = json.encode(encodeString);
      String url = Constants.BASE_URL_API + "auth/login";


      var response = await _client.post(url, headers: {"Content-Type": "application/json"}, body: encode);

      if (response.statusCode == 200) {

        var responseData = json.decode(utf8.decode(response.bodyBytes));
        User user = User.fromJson(responseData["data"]);

        //print("UserApi[signIn]-token: ${user.token}");

        return user;
      } else {
        //print("UserApi: ${response.statusCode}");
        if(response.statusCode == 500){
          return User();
        }
        return null;
      }
    } on Exception catch (error) {
      print('Exception: Erro ao realizar SignIn- $error');
      return User();
    }
  }

  Future<bool> logout(String token) async {
    try {
      String url = Constants.BASE_URL_API + "auth/logout";

      //print("UserApi[logout] - token: $token");

      var response = await _client.post(url, headers: {"Authorization": "Bearer $token"});

      if (response.statusCode != 200) {
     //   print("erro ao realizar logout ${response.statusCode}");
        return false;
      } else {
     //   print("Logout efetuado");
        return true;
      }
    } on Exception catch (error) {
      print('Exception: Erro ao realizar logout: $error');
      return false;
    }
  }
}
