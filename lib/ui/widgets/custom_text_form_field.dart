import 'package:estok_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestFocus;
  final FormFieldValidator<String> validator;
  final Icon prefixIcon;
  final bool passwordToggleButton;
  final String textAboveFormField;
  final int maxLength;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputFormatter formatter;
  final int maxLines;
  final double sizeText;
  final Color colorText;
  bool obscureText;

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
    this.textAboveFormField,
    this.maxLength,
    this.floatingLabelBehavior,
    this.maxLines = 1,
    this.colorText = const Color(0xFF495057),
    this.sizeText = 16,
    this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textAboveFormField != null)
          Container(
            padding: EdgeInsets.only(bottom: 8, top: 15),
            child: Text(
              textAboveFormField,
              textAlign: TextAlign.left,
              style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontSize: 16),
            ),
          ),
        TextFormField(
          inputFormatters: formatter != null ? [formatter] : null,
          maxLines: maxLines,
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
            floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.never,
            counterText: "",
            contentPadding: EdgeInsets.only(left: 25,right: 10,top: 10,bottom: 10),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: sizeText,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat",
              color: colorText,
            ),
            alignLabelWithHint: true,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: sizeText,
              fontWeight: FontWeight.w400,
              color:  colorText ?? Color(0xFF495057),
              height: prefixIcon != null ? 1.8 : null,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: prefixIcon != null ? Padding(
              padding: EdgeInsets.only(left: 10,right: 2),
              child: prefixIcon,
            ): null,
            suffixIcon: passwordToggleButton
                ? Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: () {
                        UserModel.of(context).passwordVisibility = !UserModel.of(context).passwordVisibility;
                        UserModel.of(context).setState();
                      },
                      icon: Icon(
                        UserModel.of(context).passwordVisibility ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                        size: 27,
                      ),
                    ),
                )
                : null,
          ),
        ),
      ],
    );
  }
}
