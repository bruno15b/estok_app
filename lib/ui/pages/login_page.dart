import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/main_page.dart';
import 'package:estok_app/ui/validator/login_validator.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget with LoginValidator {
  final FocusNode _focusPassword = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        padding: EdgeInsets.fromLTRB(27, 220, 27, 0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ESTOK APP",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Email",
                  hintText: "example@email.com",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFFC4C4C4),
                  ),
                  controller: _emailController,
                  requestFocus: _focusPassword,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 21,
                ),
                ScopedModelDescendant<UserModel>(
                    builder: (context, snapshot, userModel) {
                  return CustomTextFormField(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: "Senha",
                    hintText: "Informe a senha",
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFFC4C4C4),
                    ),
                    obscureText: userModel.showPassword,
                    passwordToggleButton: true,
                    onTogglePasswordVisibility:
                        userModel.togglePasswordVisibility,
                    focusNode: _focusPassword,
                    controller: _passwordController,
                    validator: validatePassword,
                  );
                }),
                SizedBox(
                  height: 38,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        textButton: "ENTRAR",
                        onPressed: () => _loginOnPressed(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _loginOnPressed(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (!this._formKey.currentState.validate()) {
      return;
    }

    UserModel.of(context).login(_emailController.text, _passwordController.text,
        onSuccess: () {
      Message.onSuccess(
        scaffoldKey: _scaffoldKey,
        message: "Usuário logado com sucesso",
        seconds: 2,
        onPop: (value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MainPage();
              },
            ),
          );
          UserModel.of(context).setState();
        },

      );

      StockModel.of(context).fetchStocks();
      return;
    }, onFail: (string) {
      Message.onFail(
        scaffoldKey: _scaffoldKey,
        message: "Erro ao logar. Tente novamente!",
        seconds: 2,
      );
      return;
    });

    print(
        "Email : ${_emailController.text}, Senha: ${_passwordController.text}");
  }
}
