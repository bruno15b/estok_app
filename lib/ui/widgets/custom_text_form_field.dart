import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestFocus;
  final FormFieldValidator<String> validator;
  final Icon prefixIcon;
  final Function(bool) onTogglePasswordVisibility;
  final bool passwordToggleButton;

  CustomTextFormField({
    @required this.labelText,
    @required this.hintText,
    @required this.keyboardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.requestFocus,
    this.validator,
    this.passwordToggleButton = false,
    this.prefixIcon,
    this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: (value) {
        if (this.requestFocus != null) {
          FocusScope.of(context).requestFocus(this.requestFocus);
        }
      },
      decoration: InputDecoration(
        contentPadding: prefixIcon == null
            ? EdgeInsets.fromLTRB(25, 11, 19, 9)
            : EdgeInsets.fromLTRB(52, 11, 19, 9),
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Montserrat"),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: passwordToggleButton
            ? IconButton(
                onPressed: () {
                  if (onTogglePasswordVisibility != null) {
                    onTogglePasswordVisibility(!obscureText);
                  }
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
      ),
    );
  }
}
