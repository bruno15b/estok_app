import 'package:estok_app/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() {
  runApp(MyApp(UserModel()));
}

class MyApp extends StatefulWidget {
  final UserModel userScopedModel;

  MyApp(this.userScopedModel);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: widget.userScopedModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ESTOK APP',
        theme: ThemeData(
          accentColor: Color(0xFF495057),
          primaryColor: Color(0xFF58355E),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Montserrat",
          appBarTheme: AppBarTheme(
            color: Color(0xFFF7F2F8),
            textTheme: TextTheme(
              headline6: TextStyle(
                  color: Color(0xFF58355E),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
          ),
        ),
        home: LoginPage(),
      ),
    );
  }
}
