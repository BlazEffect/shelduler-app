import 'package:scheduler/utils/base_model.dart';

import 'package:scheduler/database/db_provider.dart';

class Task {
  int? id;
  String name;
  String? description;
  DateTime startFrom;
  DateTime finishBefore;
  bool isAllDay;
  int? userId;
  int? groupId;

  Task({
    this.id,
    required this.name,
    this.description,
    required this.startFrom,
    required this.finishBefore,
    required this.isAllDay,
    this.userId,
    this.groupId
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: int.parse(data['id']),
      name: data['name'],
      description: data['description'],
      startFrom: DateTime.parse(data['start_from']),
      finishBefore: DateTime.parse(data['finish_before']),
      isAllDay: data['is_all_day'] == '1' ? true : false,
      userId: data['user_id'] == null ? null : int.parse(data['user_id']),
      groupId: data['group_id'] == null ? null : int.parse(data['group_id'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startFrom': startFrom,
      'finishBefore': finishBefore,
      'isAllDay': isAllDay,
      'userId': userId,
      'groupId': groupId
    };
  }
}

class TaskModel extends BaseModel {
  @override
  String table = 'tasks';

  @override
  getById(int id) async {
    Map<String, dynamic>? data = await super.getById(id);

    if (data != null) {
      return Task.fromMap(data);
    }
  }

  @override
  getAll() async {
    var data = await super.getAll();
    List<Task> tasks = [];

    if (data != null) {
      for (var task in data) {
        tasks.add(Task.fromMap(task.assoc()));
      }
    }

    return tasks;
  }

  @override
  delete(int id) async {
    await super.delete(id);
  }

  create(Task task) async {
    final conn = await DBProvider.db.database;

    var taskMap = task.toMap();

    await conn?.execute("INSERT INTO $table (id, name, description, user_id) VALUES (NULL, '${taskMap['name']}', '${taskMap['description']}', NULL)");
  }
}