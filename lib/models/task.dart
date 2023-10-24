import 'package:hive/hive.dart';
import 'package:scheduler/utils/base_model.dart';

import 'package:scheduler/database/db_provider.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime startFrom;
  @HiveField(4)
  DateTime finishBefore;
  @HiveField(5)
  bool isAllDay;
  @HiveField(6)
  bool isFavorite;
  @HiveField(7)
  int? userId;
  @HiveField(8)
  int? groupId;

  Task({
    this.id,
    required this.name,
    this.description,
    required this.startFrom,
    required this.finishBefore,
    required this.isAllDay,
    required this.isFavorite,
    this.userId,
    this.groupId
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'] == null ? null : int.parse(data['id']),
      name: data['name'],
      description: data['description'],
      startFrom: DateTime.parse(data['start_from']),
      finishBefore: DateTime.parse(data['finish_before']),
      isAllDay: data['is_all_day'] == '1' ? true : false,
      isFavorite: data['is_favorite'] == '1' ? true : false,
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
      'isFavorite': isFavorite,
      'userId': userId,
      'groupId': groupId,
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

  @override
  update(int id, String column, value) async {
    await super.update(id, column, value);
  }

  create(Task task) async {
    final conn = await DBProvider.db.database;

    var taskMap = task.toMap();

    int isAllDay = taskMap['isAllDay'] ? 1 : 0;
    int isFavorite = taskMap['isFavorite'] ? 1 : 0;
    var userId = taskMap['userId'] ?? 'NULL';
    var groupId = taskMap['groupId'] ?? 'NULL';

    await conn?.execute("INSERT INTO `$table` (id, name, description, start_from, finish_before, is_all_day, is_favorite, user_id, group_id) VALUES (${taskMap['id']}, '${taskMap['name']}', '${taskMap['description']}', '${taskMap['startFrom']}', '${taskMap['finishBefore']}', '$isAllDay', '$isFavorite', $userId, $groupId)");
  }

  getFavorite() async {
    List<Task> tasks = await getAll();

    List<Task> favoriteTasks = [];

    for (var task in tasks) {
      if (task.isFavorite) {
        favoriteTasks.add(task);
      }
    }

    return favoriteTasks;
  }
}