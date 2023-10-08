import 'package:flutter/material.dart';

import 'package:scheduler/models/task.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({
    super.key,
    required this.favoriteData,
    required this.refreshPage,
    required this.updateFavoriteDataState,
    required this.loadDataFunction
  });

  final List<Task> favoriteData;
  final VoidCallback refreshPage;
  final Function updateFavoriteDataState;
  final Function loadDataFunction;

  @override
  State<StatefulWidget> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  List<Widget> createTaskItems(List<Task> listTasks) {
    List<Widget> taskWidget = <Widget>[];

    for (var task in listTasks) {
      Map<String, dynamic> taskMap = task.toMap();

      taskWidget.add(
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
                  TaskModel().update(taskMap['id'], 'is_favorite', 0);
                  widget.refreshPage();
                },
                icon: const Icon(
                  Icons.star,
                  color: Colors.yellow
                ),
              ),
            ),
          )
        )
      );
    }

    if (taskWidget.isEmpty) {
      taskWidget.add(
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Нет избранных задач')
            ],
          )
        )
      );
    }

    return taskWidget;
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
        children: createTaskItems(widget.favoriteData)
      );
    }
  }

  _loadData() async {
    widget.updateFavoriteDataState(await widget.loadDataFunction());
    _isLoading = false;
  }
}