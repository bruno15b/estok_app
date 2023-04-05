import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/formatters/date_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestFocus;
  final FormFieldValidator<String> validator;
  final Icon prefixIcon;
  final bool passwordToggleButton;
  final String textAboveFormField;
  final int maxLength;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool dateFormatter;
  final int maxLines;

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
    this.dateFormatter = false,
    this.maxLines = 1,
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
          inputFormatters: dateFormatter ? [DateTextFormatter()] : null,
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
            contentPadding: EdgeInsets.fromLTRB(25, 11, 25, 11),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
            alignLabelWithHint: true,
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
                ? ScopedModelDescendant<UserModel>(builder: (context, snapshot, userModel) {
                    return IconButton(
                      onPressed: () {
                        userModel.passwordVisibility = !userModel.passwordVisibility;
                        userModel.setState();
                      },
                      icon: Icon(
                        userModel.passwordVisibility ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  })
                : null,
          ),
        ),
      ],
    );
  }
}
