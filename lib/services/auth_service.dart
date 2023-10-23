import 'package:scheduler/database/db_provider.dart';
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

  Future signUp(String email, String password) async {
    final conn = await DBProvider.db.database;
    final results = await conn?.execute("SELECT * FROM users WHERE email=$email");

    if (results!.numOfRows > 0) {
      return "Пользователь с таким email уже существует";
    }

    await conn?.execute("INSERT INTO users (id, name, email, password) VALUES (NULL, '', '$email', '$password')");
    return "Успешная регистрация";
  }
}
