import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  static const String _separator = '/';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    final formattedValue = _formatDate(newValue.text);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatDate(String value) {
    final digitsOnly = value.replaceAll(_separator, '');
    final newString = StringBuffer();
    for (var i = 0; i < digitsOnly.length; i++) {
      newString.write(digitsOnly[i]);
      if (i == 1 || i == 3) {
        newString.write(_separator);
      }
    }
    return newString.toString();
  }
}