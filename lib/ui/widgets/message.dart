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
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor),
            strokeWidth: strokeWidth ?? 5.0,
          ),
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

  static void alertDialogLoading(
    BuildContext context, {
    String title = "Aguarde! Atualizando dados do aplicativo com o servidor",
    double width,
    double height,
  }) {
    showDialog(
        barrierDismissible: false,
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
              color: Theme.of(context).primaryColor,
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Center(
                child: Container(
                  width: width ?? 40.0,
                  height: height ?? 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                    strokeWidth: 5.0,
                  ),
                ),
              ),
            ),
          );
        });
  }

  static void alertDialogConfirm(
    BuildContext context, {
    String title = "",
    String subtitle = "",
    @required String textOkButton = "Sim",
    @required Function onPressedOkButton,
    String textNoButton = "Não",
    Widget widget,
    Function onPressedNoButton,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
            ),
            content: SingleChildScrollView(
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  ListBody(
                    children: [
                      widget != null
                          ? Padding(
                            padding: EdgeInsets.only(top: 20,bottom: 60),
                            child: Container(width: 400, child: widget),
                          )
                          : Container(),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              onPressedNoButton == null
                  ? Container()
                  : FlatButton(
                      onPressed: onPressedNoButton,
                      child: Text(
                        textNoButton,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
              SizedBox(width: 15,),
              FlatButton(
                onPressed: onPressedOkButton,
                child: Text(
                  textOkButton,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(width: 15,),
            ],
          );
        });
  }
}
