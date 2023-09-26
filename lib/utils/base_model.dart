import 'package:scheduler/database/db_provider.dart';

class BaseModel {
  late String table;

  getById(String id) async {
    final conn = await DBProvider.db.database;
    final results = await conn?.execute("SELECT * FROM $table WHERE id=$id");

    if (results!.numOfRows > 0) {
      return results.rows.first.assoc();
    }
  }

  getAll() async {
    final conn = await DBProvider.db.database;
    final results = await conn?.execute("SELECT * FROM $table");

    if (results!.numOfRows > 0) {
      return results.rows;
    }
  }

  delete(String id) async {
    final conn = await DBProvider.db.database;
    await conn?.execute("DELETE FROM $table WHERE id=$id");
  }
}