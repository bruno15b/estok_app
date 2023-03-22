import 'dart:convert';
import 'package:estok_app/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepository {
  static final UserRepository instance = UserRepository._();

  UserRepository._();

  Future<void> saveUser(User user) async {
    String userString = json.encode(user.toJson());
    var instance = await SharedPreferences.getInstance();
    await instance.setString("user.prefs", userString);
  }

  Future<User> getUser() async {
    var instance = await SharedPreferences.getInstance();
    String userString = await instance.getString("user.prefs");
    instance.setString("user.prefs", userString);
    if (userString.isEmpty) {
      return null;
    }
    Map userJson = json.decode(userString);
    User user = User.fromJson(userJson);
    return user;
  }


  Future<void> saveUserCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailSalvo', email);
    await prefs.setString('senhaSalva', password);
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('emailSalvo');
  }

  Future<String> getUserPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('senhaSalva');
  }


  Future<void> deleteUser() async {
    var instance = await SharedPreferences.getInstance();
    await instance.getString("user.prefs");
  }
}