import 'package:scheduler/database/db_provider.dart';
import 'package:scheduler/utils/base_model.dart';

class User {
  int? id;
  String name;
  String email;
  String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] == null ? null : int.parse(data['id']),
      name: data['name'],
      email: data['email'],
      password: data['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password
    };
  }
}

class UserModel extends BaseModel {
  @override
  String table = 'users';

  @override
  getById(int id) async {
    Map<String, dynamic>? data = await super.getById(id);

    if (data != null) {
      return User.fromMap(data);
    }
  }

  getByEmail(String email) async {
    final conn = await DBProvider.db.database;
    final results = await conn?.execute('SELECT * FROM `$table` WHERE email="$email"');

    if (results!.numOfRows > 0) {
      return User.fromMap(results.rows.first.assoc());
    }
  }

  @override
  getAll() async {
    var data = await super.getAll();
    List<User> users = [];

    if (data != null) {
      for (var user in data) {
        users.add(User.fromMap(user.assoc()));
      }
    }

    return users;
  }

  @override
  delete(int id) async {
    await super.delete(id);
  }

  @override
  update(int id, String column, value) async {
    await super.update(id, column, value);
  }

  create(User task) async {
    final conn = await DBProvider.db.database;

    var userMap = task.toMap();

    await conn?.execute("INSERT INTO `$table` (id, name, email, password) VALUES (${userMap['id']}, '${userMap['name']}', '${userMap['email']}', '${userMap['password']}')");
  }
}