import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future<bool> loadData() async {
    await Future.delayed(Duration(seconds: 4));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<bool>(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {

              return LoginPage();
            } else {
              return Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("ESTOK APP", style: TextStyle(color:Color(0xFFE3E1E1), fontSize: 34 ),),
                    SizedBox(height: 35,),
                    Container(
                      height: 42,
                      width: 42,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );

            }
          },
        ),
      ),
    );
  }
}