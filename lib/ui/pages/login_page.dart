import 'package:estok_app/entities/user.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/pages/history_page.dart';
import 'package:estok_app/ui/pages/main_page.dart';
import 'package:estok_app/ui/validators/login_validator.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 57,
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
                    size: 26,
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
                        size: 26,
                      ),
                      obscureText: userModel.passwordVisibility,
                      passwordToggleButton: true,
                      focusNode: _focusPassword,
                      controller: _passwordController,
                      validator: validatePassword,
                    );
                  },
                ),
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
            height: 40,
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

    UserModel.of(context).login(_emailController.text, _passwordController.text, onSuccess: () {
      Message.onSuccess(
        scaffoldKey: _scaffoldKey,
        message: "Usuário logado com sucesso",
        seconds: 2,
        onPop: (_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MainPage();
              },
            ),
          );
        },
      );

      StockModel.of(context).fetchAllStocks();
      return;
    }, onFail: (errorText) {
      Message.onFail(
          scaffoldKey: _scaffoldKey,
          seconds: 2,
          message: errorText,
          onPop: (_) async {
            String password = await UserRepository.instance.getUserPassword();
            User user = await UserRepository.instance.getUser();
            if (_emailController.text == user.email && _passwordController.text == password) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: CustomAppBar(
                        titleText: "Histórico",
                        automaticallyImplyLeading: true,
                      ),
                      body: HistoryPage(),
                    );
                  },
                ),
              );
            }
          });
      return;
    });

    print("Email : ${_emailController.text}, Senha: ${_passwordController.text}");
  }
}
