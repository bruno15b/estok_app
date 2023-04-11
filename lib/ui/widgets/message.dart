import 'package:estok_app/enums/stock_type_enum.dart';
import 'package:estok_app/enums/extensions/stock_type_enum_extension.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget{
   final String message;
   final double fontSize;
   final Color color;
   final FontWeight fontWeight;
   final void Function() onPressed;

   Message(this.message, {this.fontSize, this.color = Colors.grey, this.fontWeight = FontWeight.bold,this.onPressed});

   @override
  Widget build(BuildContext context) {
    return Container(
      key:ValueKey('message'),
      padding: EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          message,
          style: TextStyle(
            fontSize: fontSize ?? 15,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
        onPressed != null
            ? TextButton(
          onPressed: onPressed,
          style: ButtonStyle(),
          child: Text(
            "Clique aqui para recarregar",
            style: TextStyle(color: color),
          ),
        )
            : SizedBox()
      ]),
    );
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
      Future.delayed(Duration(milliseconds: seconds != null ? seconds * 1000 : 700)).then(onPop);
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
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).textTheme.bodyText2.color),
            strokeWidth: strokeWidth ?? 5.0,
          ),
        ),
      ),
    );
  }


  static void alertDialogLoading(
    BuildContext context, {
    String title = "Aguarde! Atualizando os dados do aplicativo com o servidor",
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
              color: Theme.of(context).textTheme.bodyText2.color,
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30, bottom: 40),
              child: Center(
                child: Container(
                  width: width ?? 40.0,
                  height: height ?? 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).textTheme.bodyText2.color),
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
    String textOkButton = "Sim",
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
              color: Theme.of(context).primaryColor,
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
                              padding: EdgeInsets.only(top: 20, bottom: 40),
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
                          color: Theme.of(context).textTheme.bodyText2.color,
                        ),
                      ),
                    ),
              SizedBox(
                width: 15,
              ),
              FlatButton(
                onPressed: onPressedOkButton,
                child: Text(
                  textOkButton,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          );
        });
  }

  static void alertDialogChooser(
    BuildContext context, {
    List<StockTypeEnum> listStockTypeEnum,
    StockModel stockModel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: ValueKey('dialogWidgetKey'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                listStockTypeEnum.length,
                (index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        String _selectedStockTypeOption = listStockTypeEnum[index].stringValue;
                        stockModel.onChangeTypeOfStock(_selectedStockTypeOption);
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                          child: Text(
                            listStockTypeEnum[index].stringValue,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ),
                    index < listStockTypeEnum.length - 1 ? Divider() : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
