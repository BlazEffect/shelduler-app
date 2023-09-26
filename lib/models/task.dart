import 'package:scheduler/utils/base_model.dart';

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
          description: data["description"],
          userId: data["user_id"] ?? ""
      );
    }
  }

  @override
  getAll() async {
    var data = await super.getAll();
    List<Task> tasks = [];

    for (var task in data) {
      tasks.add(
        Task(
          id: task.assoc()["id"],
          name: task.assoc()["name"],
          description: task.assoc()["description"],
          userId: task.assoc()["user_id"] ?? ""
        )
      );
    }

    return tasks;
  }

  @override
  delete(String id) async{
    await super.delete(id);
  }
}