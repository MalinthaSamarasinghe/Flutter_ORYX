class RegularExpressions {
  /// Check Valid Name
  /// Allowed - en & de characters, spaces
  /// Not Allowed - Special characters, Numbers,
  /// static RegExp fullName = RegExp(r'^[A-Za-zÀ-ȕ ]+$');
  static RegExp fullName = RegExp(r"^[A-Za-zÀ-ȕ ,.'-]+$");

  /// Check Valid Email
  static RegExp email = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Check Valid Password Characters
  static RegExp passwordCharacters = RegExp(r'(?=.{8,})');

  /// Check Valid PasswordUppercase
  static RegExp passwordUppercase = RegExp(r'(?=.*[A-Z])');

  /// Check Valid PasswordLowercase
  static RegExp passwordLowercase = RegExp(r'(?=.*[a-z])');

  /// Check Valid PasswordSpecial
  static RegExp passwordSpecial = RegExp(r'([^A-Za-z0-9])');
}
