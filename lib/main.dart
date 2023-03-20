
import 'package:estok_app/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              fontSize: 15
            ),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
