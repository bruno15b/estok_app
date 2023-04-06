import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && !newValue.text.startsWith('R\$ ')) {
      return TextEditingValue(
        text: 'R\$ ' + newValue.text,
        selection: TextSelection.fromPosition(TextPosition(offset: newValue.text.length + 3)),
      );
    }
    return newValue;
  }
}