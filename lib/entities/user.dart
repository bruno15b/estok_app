class User {
  int id;
  String name;
  String email;
  String password;
  String telephone;
  String token;

  static const String ID_FIELD = "id";
  static const String NAME_FIELD = "name";
  static const String EMAIL_FIELD = "email";
  static const String PASSWORD_FIELD = "password";
  static const String TELEPHONE_FIELD = "telephone";
  static const String TOKEN_FIELD = "token";

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.telephone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json[ID_FIELD] as num),
      name: (json[NAME_FIELD] as String),
      email: (json[EMAIL_FIELD] as String),
      password: (json[PASSWORD_FIELD] as String),
      telephone: (json[TELEPHONE_FIELD] as String),
      token: (json[TOKEN_FIELD] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ID_FIELD: id,
      NAME_FIELD: name,
      EMAIL_FIELD: email,
      PASSWORD_FIELD: password,
      TELEPHONE_FIELD: telephone,
      TOKEN_FIELD: token,
    };
  }
}
