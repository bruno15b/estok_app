import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.onTogglePasswordVisibility,
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
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
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
            floatingLabelBehavior:
                floatingLabelBehavior ?? FloatingLabelBehavior.never,
            counterText: "",
            contentPadding: EdgeInsets.fromLTRB(25, 11, 25, 11),
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Montserrat"),
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

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
