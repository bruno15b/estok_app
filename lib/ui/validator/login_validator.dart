
class LoginValidator {

  bool _isInvalidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  String validateEmail(String value) {
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
    } else if (value.length < 8) {
      return "Campo deve conter no mínimo 8 caracteres";
    } else {
      return null;
    }
  }
}