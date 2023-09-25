import 'package:scheduler/database/db_provider.dart';

class AuthService {
  Future<String> signIn(String email, String password) async {
    final conn = await DBProvider.db.database;
    final results = await conn?.execute('SELECT * FROM users WHERE email="$email"');

    for (var user in results!.rows) {
      String? userPassword = user.assoc()['password'];

      if (userPassword != password) {
        return 'Не правильный email или пароль';
      } else {
        return 'Успешная авторизация';
      }
    }

    return 'Не правильный email или пароль';
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
