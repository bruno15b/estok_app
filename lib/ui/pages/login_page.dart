import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                padding: EdgeInsets.fromLTRB(27, 183, 27, 0),
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              primary: Color(0xFFF7F2F8),
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
}
