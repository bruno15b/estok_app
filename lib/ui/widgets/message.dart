import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void onSuccess({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required String message,
    int seconds,
    Function onPop,
  }) async {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: seconds ?? 2),
      ),
    );
    if (onPop != null) {
      Future.delayed(Duration(seconds: seconds ?? 2)).then(onPop);
    }
  }

  static void onFail({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required String message,
    int seconds,
    Function onPop,
  }) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[800],
        duration: Duration(seconds: seconds ?? 2),
      ),
    );
    if (onPop != null) {
      Future.delayed(Duration(seconds: seconds ?? 2)).then(onPop);
    }
  }

  static Widget loading(
    BuildContext context, {
    double width,
    double height,
    double strokeWidth,
    Color color,
  }) {
    return Center(
      child: Container(
        width: width ?? 40.0,
        height: height ?? 40.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).accentColor),
          strokeWidth: strokeWidth ?? 5.0,
        ),
      ),
    );
  }

  static Widget alert(
    message, {
    double fontSize,
    double fontWeight,
    Color color,
    void Function() onPressed,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          message,
          style: TextStyle(
            fontSize: fontSize ?? 15,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: color ?? Colors.grey[600],
          ),
        ),
        TextButton(
            onPressed: onPressed,
            style: ButtonStyle(),
            child: Text(
              "Clique aqui para recarregar",
              style: TextStyle(color: color),
            ))
      ]),
    );
  }

  static void alertDialog(
    BuildContext context, {
    String title = "",
    String subtitle,
    @required String textOkButton = "sim",
    @required Function onPressedOkButton,
    String textNoButton = "Não",
    Function onPressedNoButton,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            actions: [
                    FlatButton(
                      onPressed: onPressedOkButton,
                      child: Text(
                        textOkButton,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    onPressedNoButton == null
                        ? Container()
                        : FlatButton(
                            onPressed: onPressedNoButton,
                            child: Text(
                              textNoButton,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          )
                  ],
          );
        });
  }
}
