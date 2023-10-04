import 'package:scheduler/utils/base_model.dart';

import 'package:scheduler/database/db_provider.dart';

class Task {
  String id;
  String name;
  String description;
  String userId;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data["id"],
      name: data["name"],
      description: data["description"],
      userId: data["userId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "userId": userId,
    };
  }
}

class TaskModel extends BaseModel {
  @override
  String table = "tasks";

  @override
  getById(String id) async {
    var data = await super.getById(id);

    if (data is Map) {
      return Task(
          id: data["id"],
          name: data["name"],
          description: data["description"] ?? "",
          userId: data["user_id"] ?? ""
      );
    }
  }

  @override
  getAll() async {
    var data = await super.getAll();
    List<Task> tasks = [];

    if (data != null) {
      for (var task in data) {
        tasks.add(
          Task(
            id: task.assoc()["id"],
            name: task.assoc()["name"],
            description: task.assoc()["description"] ?? "",
            userId: task.assoc()["user_id"] ?? ""
          )
        );
      }
    }

    return tasks;
  }

  @override
  delete(String id) async {
    await super.delete(id);
  }

  create(Task task) async {
    final conn = await DBProvider.db.database;

    var taskMap = task.toMap();

    await conn?.execute("INSERT INTO $table (id, name, description, user_id) VALUES (NULL, '${taskMap['name']}', '${taskMap['description']}', NULL)");
  }
}