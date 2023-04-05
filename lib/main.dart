import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/ui/pages/main_page.dart';
import 'package:estok_app/ui/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/user_model.dart';

void main() {
  runApp(MyApp(UserModel(), StockModel(), ProductModel(),HistoryModel()));
}

class MyApp extends StatefulWidget {
  final UserModel userScopedModel;
  final StockModel stockScopedModel;
  final ProductModel productScopedModel;
  final HistoryModel historyScopedModel;

  MyApp(this.userScopedModel, this.stockScopedModel, this.productScopedModel,this.historyScopedModel);

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
          child: ScopedModel(
            model: widget.historyScopedModel,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ESTOK APP',
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText2: TextStyle(
                    color: Color(0xFF495057),
                  ),
                ),
                primaryColor: Color(0xFF58355E),
                accentColor: Color(0xFFF7F2F8),
                scaffoldBackgroundColor: Colors.white,
                dividerColor: Color(0xFFBEBBBB),
                fontFamily: "Montserrat",
              ),
              home: SplashScreenPage(),
            ),
          ),
        ),
      ),
    );
  }
}
