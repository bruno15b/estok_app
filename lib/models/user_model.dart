import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
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

      await UserRepository.instance.saveUser(user);
      await UserRepository.instance.saveUserCredentials(email, password);
      await UserRepository.instance.saveUserToken(user.token);

      onSuccess();

    } else {
      onFail("Erro ao efetuar login em: $email");
    }
  }

  void renewToken() async{
   String token = await UserApi.instance.renewToken( await UserRepository.instance.getUserEmail(), await UserRepository.instance.getUserPassword());
    print("renewToken: $token");
   await UserRepository.instance.saveUserToken(token);
  }


  void logout() async{
    await renewToken();
    await UserApi.instance.logout(await UserRepository.instance.getUserToken());
    UserRepository.instance.clearUserData();
    StockRepository.instance.clearStockData();
  }
}
