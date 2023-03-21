import 'package:flutter/material.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User user;

  static UserModel of(BuildContext context) {
    return ScopedModel.of<UserModel>(context);
  }

  void login(String email, String password,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {

    user = await UserApi.instance.signIn(email, password);
    if (user != null) {
      onSuccess();
    } else {
      onFail("Erro ao efetuar login em: $email");
    }
  }
}