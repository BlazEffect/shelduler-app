import 'package:flutter/material.dart';

import 'package:scheduler/models/group.dart';

class GroupTab extends StatefulWidget {
  const GroupTab({
    super.key,
    required this.groupData,
    required this.refreshPage,
    required this.updateGroupDataState,
    required this.loadDataFunction
  });

  final List<Group> groupData;
  final VoidCallback refreshPage;
  final Function updateGroupDataState;
  final Function loadDataFunction;

  @override
  State<StatefulWidget> createState() => _TaskTabState();
}

class _TaskTabState extends State<GroupTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  List<Widget> createGroupItems(List<Group> listGroups) {
    List<Widget> groupWidget = <Widget>[];

    for (var group in listGroups) {
      Map<String, dynamic> groupMap = group.toMap();

      groupWidget.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.deepPurple[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(groupMap['name']),
              trailing: IconButton(
                onPressed: () {
                  GroupModel().delete(groupMap['id']);
                  widget.refreshPage();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          )
        )
      );
    }

    if (groupWidget.isEmpty) {
      groupWidget.add(
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Нет групп')
            ],
          )
        )
      );
    }

    return groupWidget;
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
        children: createGroupItems(widget.groupData)
      );
    }
  }

  _loadData() async {
    widget.updateGroupDataState(await widget.loadDataFunction());
    _isLoading = false;
  }
}