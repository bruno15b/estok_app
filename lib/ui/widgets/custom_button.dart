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
  final double heightCircle;
  final double widthCircle;
  final double strokeWidth;
  final Color colorCircularProgress;
  bool isLoading;

  CustomButton({
    @required this.textButton,
    this.onPressed,
    this.height = 46,
    this.width,
    this.borderRadius,
    this.colorText,
    this.colorButton,
    this.fontSize,
    this.heightCircle = 20,
    this.widthCircle = 20,
    this.strokeWidth = 2.5,
    this.colorCircularProgress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        onPressed: onPressed,
        child: isLoading
            ? Container(
                width: widthCircle,
                height: heightCircle,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorCircularProgress ?? Theme.of(context).primaryColor,
                  ),
                  strokeWidth: strokeWidth,
                ),
              )
            : Text(
                textButton,
                style: TextStyle(
                  color: colorText ?? Color(0xFF463E47),
                  fontSize: fontSize ?? 15.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        color: colorButton ?? Theme.of(context).accentColor,
      ),
    );
  }
}
