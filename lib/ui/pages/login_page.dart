import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/validator/login_validator.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginValidator {
  final FocusNode _focusPassword = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showPassword = false;

  void _togglePasswordView(bool isVisible) {
    setState(() {
      _showPassword = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(27, MediaQuery.of(context).size.height * 0.232, 27, 0),
                child: Column(
                  children: [
                    Text(
                      "ESTOK APP",
                      style: TextStyle(color: Theme.of(context).accentColor,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 0, 26, 50),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomTextFormField(
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
                      CustomTextFormField(
                        labelText: "Senha",
                        hintText: "Informe a senha",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFC4C4C4),
                        ),
                        obscureText: !_showPassword,
                        passwordToggleButton: true,
                        onTogglePasswordVisibility: _togglePasswordView,
                        focusNode: _focusPassword,
                        controller: _passwordController,
                        validator: validatePassword,
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: ()=>_loginOnPressed(context),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              primary: Theme.of(context).appBarTheme.color,
                              elevation: 0),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _loginOnPressed(BuildContext context) {

    FocusScope.of(context).unfocus();

    if (!this._formKey.currentState.validate()) {
      return;
    }

    UserModel.of(context).login(_emailController.text, _passwordController.text,
        onSuccess: () {
          Message.onSuccess(
              scaffoldKey: _scaffoldKey,
              message: "Usuário logado com sucesso",
              seconds: 4,
              onPop: (value) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return HomePage();
                }));
              });
          return;
        }, onFail: (String) {
          Message.onFail(
            scaffoldKey: _scaffoldKey,
            message: "Erro ao logar. Tente novamente!",
            seconds: 4,
          );
          return;
        });

    print("Email : ${_emailController.text}, Senha: ${_passwordController.text}");
  }
}
