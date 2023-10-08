import 'package:scheduler/utils/base_model.dart';

import 'package:scheduler/database/db_provider.dart';

class Group {
  int? id;
  int? parentId;
  String name;
  String? description;
  int? userId;

  Group({
    this.id,
    this.parentId,
    required this.name,
    this.description,
    this.userId,
  });

  factory Group.fromMap(Map<String, dynamic> data) {
    return Group(
      id: data['id'] == null ? null : int.parse(data['id']),
      parentId: data['parent_id'] == null ? null : int.parse(data['parent_id']),
      name: data['name'],
      description: data['description'],
      userId: data['user_id'] == null ? null : int.parse(data['user_id']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'description': description,
      'userId': userId,
    };
  }
}

class GroupModel extends BaseModel {
  @override
  String table = 'groups';

  @override
  getById(int id) async {
    Map<String, dynamic>? data = await super.getById(id);

    if (data != null) {
      return Group.fromMap(data);
    }
  }

  @override
  getAll() async {
    var data = await super.getAll();
    List<Group> groups = [];

    if (data != null) {
      for (var group in data) {
        groups.add(Group.fromMap(group.assoc()));
      }
    }

    return groups;
  }

  @override
  delete(int id) async {
    await super.delete(id);
  }

  create(Group group) async {
    final conn = await DBProvider.db.database;

    var groupMap = group.toMap();

    var parentId = groupMap['parentId'] ?? 'NULL';
    var userId = groupMap['userId'] ?? 'NULL';

    await conn?.execute("INSERT INTO `$table` (id, parent_id, name, description, user_id) VALUES (${groupMap['id']}, $parentId, '${groupMap['name']}', '${groupMap['description']}', $userId)");
  }
}