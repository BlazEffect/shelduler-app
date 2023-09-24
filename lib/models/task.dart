class Task {
  int id;
  String name;
  String description;
  int userId;

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

class TaskModel {
}