class StockRegisterValidator {
  String validateDate(String date) {
    if (date == null || date.isEmpty) {
      return "Campo Vazio";
    }

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (!regex.hasMatch(date)) {
      return "xx/xx/xxxx*";
    }

    final parts = date.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return "Data inexistente";
    }

    if (month < 1 || month > 12) {
      return "Mês inválido";
    }

    final daysInMonth = DateTime(year, month + 1, 0).day;
    if (day < 1 || day > daysInMonth) {
      return "Dia inválido";
    }

    return null;
  }

  String compareDates(DateTime date1, DateTime date2) {
    if (date1.isAfter(date2)) {
      return 'A data de validade é superior a de entrada';
    }
    return null;
  }
}
