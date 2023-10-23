import 'package:scheduler/models/user.dart';

class AuthService {
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    User? user = await UserModel().getByEmail(email);

    if (user?.password == password) {
      return {
        'message': 'Успешная авторизация',
        'user': user,
        'isAuth': true
      };
    } else {
      return {
        'message': 'Неправильный email или пароль',
        'user': null,
        'isAuth': false
      };
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    User? user = await UserModel().getByEmail(email);

    if (user != null) {
      return {
        'message': 'Пользователь с таким email уже существует',
        'isRegister': false
      };
    }

    Map<String, dynamic> userMap = {
      'name': '',
      'email': email,
      'password': password,
    };

    UserModel().create(User.fromMap(userMap));
    return {
      'message': 'Успешная регистрация',
      'isRegister': true
    };
  }
}
