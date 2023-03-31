import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;
  final Color colorText;
  final Color colorButton;

  CustomButton({
    @required this.textButton,
    this.onPressed,
    this.height=40,
    this.width,
    this.borderRadius,
    this.colorText,
    this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        child: Text(
          textButton,
          style: TextStyle(
              color: colorText ?? Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:borderRadius ?? BorderRadius.circular(15),
          ),
          primary:colorButton ?? Theme.of(context).appBarTheme.color,
          elevation: 0,
        ),
      ),
    );
  }
}
