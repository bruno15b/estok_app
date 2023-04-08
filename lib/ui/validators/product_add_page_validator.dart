class ProductAddPageValidator {

  String onlyNumbersValidator(String value) {

    if (value.isEmpty) {
      return 'Campo vazio';
    }

    final regex = RegExp(r'^[0-9]+$');

    if (!regex.hasMatch(value)) {
      return 'Apenas números inteiros são permitidos';
    }

    if(value.length>15){
      return 'Campo excede o limite de 15 caracteres';
    }
    return null;
  }

  String urlValidator(String value) {
    if (value.isEmpty) {
      return "Campo Vazio";
    }

    final regex = RegExp(r'^((https?|ftp|smtp):\/\/)?(www\.)?[a-z0-9]+\.[a-z]+(\.[a-z]+)?(\/[a-zA-Z0-9#]+\/?)*$');

    if (!regex.hasMatch(value)) {
      return "URL inválida";
    }

    if(value.length>40){
      return 'Campo excede o limite de 40 caracteres';
    }

    return null;
  }

  String currencyValidator(String value) {
    if (value.isEmpty) {
      return 'Campo vazio';
    }

    if (value.contains(',') && value.lastIndexOf(',') != value.indexOf(',')) {
      return 'Apenas uma vírgula é permitida';
    }

    if (value.contains('.') && value.lastIndexOf('.') != value.indexOf('.')) {
      return 'Apenas um ponto é permitido';
    }

    if (double.tryParse(value.replaceAll(RegExp(r'^[R$\s]+'), '').replaceAll(',', '.')) == null) {
      return 'Apenas números!';
    }

    final regex = RegExp(r'^R?\$\s?\d+(?:,\d+)?(?:\.\d+)?|\d+$');
    if (!regex.hasMatch(value)) {
      return 'Apenas números!Com . ou ,!';
    }

    return null;
  }

  String nameValidator(String value) {
    if (value.trim().isEmpty) {
      return "Campo vazio";
    } else if (value.length > 21) {
      return "Campo excede o limite de 21 caracteres";
    } else {
      return null;
    }
  }

  String descriptionValidator(String value) {
    if (value.trim().isEmpty) {
      return "Campo vazio";
    } else if (value.length > 85) {
      return "Campo excede o limite de 85 caracteres";
    } else {
      return null;
    }
  }
}
