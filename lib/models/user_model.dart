import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User user;
  bool showPassword = true;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
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
      await UserRepository.instance.saveUserCredentials(email, password);
      await UserRepository.instance.saveUserToken(user.token);

      onSuccess();

    } else {
      onFail("Erro ao efetuar login em: $email");
    }
  }

  void logout() async{

   var userToken = await UserRepository.instance.getUserToken();

   bool logout = await UserApi.instance.logout(userToken);

   if(logout) {
     await UserRepository.instance.clearUserData();
     await StockRepository.instance.clearStockData();
   }
  }

  void togglePasswordVisibility(bool isVisible) {
    showPassword = !showPassword;
    notifyListeners();
  }

}
