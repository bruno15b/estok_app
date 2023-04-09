class StockAddPageValidator {

  String dateValidator(String date) {

    if (date == null || date.isEmpty) {
      return "Campo Vazio";
    }

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (!regex.hasMatch(date)) {
      return "dd/mm/yyyy*";
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

    if(year>2037){
      return "Somente =< 2037";
    }

    if(year<1971){
      return "Somente >= 1971";
    }

    return null;
  }

  String descriptionValidator(String value) {
    if (value.trim().isEmpty) {
      return "Campo vazio";
    } else if (value.length > 22) {
      return "Campo excede o limite de 22 caracteres";
    } else {
      return null;
    }
  }

}
