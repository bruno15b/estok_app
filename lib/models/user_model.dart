import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User user;
  bool showPassword = true;

  int currentIndexPage = 0;

  setState(){
    notifyListeners();
  }


  static UserModel of(BuildContext context) {
    return ScopedModel.of<UserModel>(context);
  }

  void login(String email, String password,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {

    user = await UserApi.instance.signIn(email, password);

    if (user != null) {

      await UserRepository.instance.saveUser(user);
      await UserRepository.instance.saveUserPassword(password);


      onSuccess();

    } else {
      onFail("Erro ao efetuar login em: $email");
    }
  }

  Future<void> logout() async{

   User user = await UserRepository.instance.getUser();

   bool logout = await UserApi.instance.logout(user.token);

   if(logout) {
     await UserRepository.instance.clearUserData();
     await StockRepository.instance.clearStockData();
   }
  }

  void togglePasswordVisibility(bool isVisible) {
    showPassword = !showPassword;
    setState();
  }

  void changePage(int newIndexPage) {
    currentIndexPage = newIndexPage;
    setState();
  }

}
