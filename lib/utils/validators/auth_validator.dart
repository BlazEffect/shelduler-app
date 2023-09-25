class AuthValidator {
  static const String emailErrMsg = "Неверный адрес электронной почты, пожалуйста, укажите действительный адрес электронной почты.";
  static const String passwordErrMsg = "Пароль должен содержать не менее 6 символов.";
  static const String confirmPasswordErrMsg = "Два пароля не совпадают.";

  String? emailValidator(String? val) {
    final String email = val as String;

    if (email.length <= 3) return emailErrMsg;

    final hasAtSymbol = email.contains('@');
    final indexOfAt = email.indexOf('@');
    final numbersOfAt = "@".allMatches(email).length;

    if (!hasAtSymbol) return emailErrMsg;

    if (numbersOfAt != 1) return emailErrMsg;

    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    return null;
  }

  String? passwordValidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    return null;
  }

  String? confirmPasswordValidator(String? val, firstPasswordInpTxt) {
    final String firstPassword = firstPasswordInpTxt;
    final String secondPassword = val as String;
    if (firstPassword.isEmpty ||
        secondPassword.isEmpty ||
        firstPassword.length != secondPassword.length) {
      return confirmPasswordErrMsg;
    }

    if (firstPassword != secondPassword) return confirmPasswordErrMsg;

    return null;
  }
}