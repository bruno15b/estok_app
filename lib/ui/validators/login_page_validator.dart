class LoginPageValidator {
  bool _isInvalidEmail(String email) {
    email = email.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  String validateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (this._isInvalidEmail(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (value.length < 5) {
      return "Campo deve conter no mínimo 5 caracteres";
    } else {
      return null;
    }
  }
}
