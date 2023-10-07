import 'package:flutter/material.dart';

import 'package:scheduler/models/task.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({
    super.key,
    required this.taskData,
    required this.updateDeleteState
  });

  final List<Task> taskData;
  final VoidCallback updateDeleteState;

  @override
  State<StatefulWidget> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  List<Widget> createTaskItems(List<Task> listTasks) {
    List<Widget> tasksWidget = <Widget>[];

    for (var task in listTasks) {
      Map<String, dynamic> taskMap = task.toMap();

      tasksWidget.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.deepPurple[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(taskMap['name']),
              trailing: IconButton(
                onPressed: () {
                  TaskModel().delete(taskMap['id']);
                  widget.updateDeleteState();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          )
        )
      );
    }

    return tasksWidget;
  }

  @override
  Widget build(BuildContext context) {
    final tasks = createTaskItems(widget.taskData);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: tasks
    );
  }
}