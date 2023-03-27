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
  final String textAboveFormField;
  final int maxLength;

  CustomTextFormField({
    @required this.labelText,
    @required this.hintText,
    @required this.keyboardType,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.requestFocus,
    this.passwordToggleButton = false,
    this.prefixIcon,
    this.onTogglePasswordVisibility,
    this.textAboveFormField,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textAboveFormField != null)
          Container(
            padding: EdgeInsets.only(bottom: 8, top: 19),
            child: Text(textAboveFormField, textAlign: TextAlign.left),
          ),

        TextFormField(
          maxLength: maxLength ?? null,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onFieldSubmitted: (value) {
            if (this.requestFocus != null) {
              FocusScope.of(context).requestFocus(this.requestFocus);
            }
          },
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.fromLTRB(25, 11, 25, 11),
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
        ),
      ],
    );
  }
}
