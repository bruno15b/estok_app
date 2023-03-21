import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void onSuccess(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
        @required String message,
        int seconds,
        Function onPop}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(scaffoldKey.currentContext).accentColor,
      duration: Duration(seconds: seconds ?? 4),
    ));
    if(onPop!= null){
      Future.delayed(Duration(seconds: seconds??4)).then(onPop);
    }
  }

  static void onFail(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
        @required String message,
        int seconds,
        Function onPop}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[800],
      duration: Duration(seconds: seconds ?? 2),
    ));
    if(onPop!= null){
      Future.delayed(Duration(seconds: seconds??2)).then(onPop);
    }
  }
}