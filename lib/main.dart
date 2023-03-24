import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/login_page.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/user_model.dart';


void main() {
  runApp(MyApp(UserModel(),StockModel(),ProductModel()));
}

class MyApp extends StatefulWidget {
  final UserModel userScopedModel;
  final StockModel stockScopedModel;
  final ProductModel productScopedModel;

  MyApp(this.userScopedModel,this.stockScopedModel,this.productScopedModel);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: widget.userScopedModel,
      child: ScopedModel(
        model: widget.stockScopedModel,
        child: ScopedModel(
          model: widget.productScopedModel,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ESTOK APP',
            theme: ThemeData(
              accentColor: Color(0xFF495057),
              primaryColor: Color(0xFF58355E),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: "Montserrat",
              appBarTheme: AppBarTheme(

                elevation: 0,
                iconTheme: IconThemeData(
                  color: Color(0xFF58355E),
                ),
                color: Color(0xFFF7F2F8),
                textTheme: TextTheme(
                  headline6: TextStyle(
                      color: Color(0xFF58355E),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
              tabBarTheme: TabBarTheme(
                labelPadding: EdgeInsets.only(top: 0),
                unselectedLabelStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(
                  fontSize: 12,
                ),
                labelColor: Color(0xFF58355E),
                unselectedLabelColor: Color(0xFF909FAD),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF58355E),
                      width: 6,
                    ),
                  ),
                ),
              ),
            ),
            home: LoginPage(),
          ),
        ),
      ),
    );
  }
}
