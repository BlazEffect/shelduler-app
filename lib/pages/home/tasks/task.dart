import 'package:flutter/material.dart';

import 'package:scheduler/models/task.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({
    super.key,
    required this.taskData,
    required this.refreshPage,
    required this.updateTaskDataState,
    required this.loadDataFunction
  });

  final List<Task> taskData;
  final VoidCallback refreshPage;
  final Function updateTaskDataState;
  final Function loadDataFunction;

  @override
  State<StatefulWidget> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

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
                  widget.refreshPage();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          )
        )
      );
    }

    if (tasksWidget.isEmpty) {
      tasksWidget.add(
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Нет задач')
            ],
          )
        )
      );
    }

    return tasksWidget;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator()
      );
    } else {
      return ListView(
        padding: const EdgeInsets.all(20),
        children: createTaskItems(widget.taskData)
      );
    }
  }

  _loadData() async {
    widget.updateTaskDataState(await widget.loadDataFunction());
    _isLoading = false;
  }
}