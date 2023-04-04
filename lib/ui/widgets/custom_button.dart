import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;
  final Color colorText;
  final Color colorButton;
  final double fontSize;

  CustomButton({
    @required this.textButton,
    this.onPressed,
    this.height=40,
    this.width,
    this.borderRadius,
    this.colorText,
    this.colorButton,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        child: Text(
          textButton,
          style: TextStyle(
              color: colorText ?? Theme.of(context).primaryColor,
              fontSize: fontSize ?? 15,
              fontWeight: FontWeight.w500),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius:borderRadius ?? BorderRadius.circular(15),
        ),
        color: colorButton ?? Theme.of(context).accentColor,
      ),
    );
  }
}