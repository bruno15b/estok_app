import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;

  CustomButton({@required this.textButton,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        child: Text(
          textButton,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        ),
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            primary: Theme.of(context).appBarTheme.color,
            elevation: 0),
      ),
    );
  }
}
