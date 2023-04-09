import 'package:estok_app/enums/upload_progress_enum.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool passwordVisibility = true;
  int currentIndexMainPage = 0;
  UploadProgressEnum userUploadProgressChange = UploadProgressEnum.IDLE;

  setState() {
    notifyListeners();
  }

  static UserModel of(BuildContext context) {
    return ScopedModel.of<UserModel>(context);
  }

  void login(String email, String password, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    User user = await UserApi.instance.signIn(email, password);

    if (user != null && user.email != null && user.id != null) {
      await UserRepository.instance.saveUser(user);
      await UserRepository.instance.saveUserPassword(password);

      onSuccess();
    } else if (user == null) {
      onFail("Erro ao logar! Verifique o email e senha!");
    } else {
      String savePassword = await UserRepository.instance.getUserPassword();
      User user = await UserRepository.instance.getUser();
      if (email == user.email && password == savePassword) {
        onFail("Sem conexão com o servidor! Carregando Histórico!");
      } else {
        onFail("Sem conexão com o servidor!");
      }
    }
    setState();
  }

  Future<void> logout({VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    User user = await UserRepository.instance.getUser();
    bool logoutResponse = await UserApi.instance.logout(user.token);
    if(logoutResponse){
      onSuccess();
    }else{
      onFail("Erro ao fazer logout!");
    }
  }
}
