import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scheduler/pages/home/tasks/task.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';
import 'package:scheduler/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Task> _taskData = [];

  late final TabController _tabController;

  final List<Map<String, dynamic>> _tabsList = [
    {
      'name': 'Задачи',
      'icon': const Icon(Icons.task_alt),
      'callFunction': TaskModel().getAll
    },
    {
      'name': 'Группы',
      'icon': const Icon(Icons.folder_outlined),
      'callFunction': TaskModel().getAll
    },
    {
      'name': 'Избранное',
      'icon': const Icon(Icons.star_outline),
      'callFunction': TaskModel().getAll
    }
  ];

  void updateTaskList(List<Task> data) => setState((){_taskData = data;});

  void refreshPage() => setState((){});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int tabIndex = _tabController.index;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: _createTabs(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TaskTab(
            taskData: _taskData,
            refreshPage: refreshPage,
            updateTaskDataState: updateTaskList,
            loadDataFunction: _tabsList[tabIndex]['callFunction'],
          ),
          // Temporary display of the same information on all tabs
          TaskTab(
            taskData: _taskData,
            refreshPage: refreshPage,
            updateTaskDataState: updateTaskList,
            loadDataFunction: _tabsList[tabIndex]['callFunction'],
          ),
          TaskTab(
            taskData: _taskData,
            refreshPage: refreshPage,
            updateTaskDataState: updateTaskList,
            loadDataFunction: _tabsList[tabIndex]['callFunction'],
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        animationCurve: Curves.elasticInOut,
        renderOverlay: false,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.folder_outlined),
            backgroundColor: Colors.deepPurple[300],
            foregroundColor: Colors.white,
            label: 'Группа',
            onTap: () {},
            shape: const CircleBorder(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.task_alt),
            backgroundColor: Colors.deepPurple[300],
            foregroundColor: Colors.white,
            label: 'Задача',
            onTap: () {
              var route = ModalRoute.of(context);

              if (route != null && route.settings.name != '/create_task') {
                Navigator.pushNamed(context, '/create_task');
              }
            },
            shape: const CircleBorder(),
          )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  List<Tab> _createTabs() {
    List<Tab> tabs = [];

    for (var element in _tabsList) {
      tabs.add(
        Tab(
          icon: element['icon'],
          text: element['name'],
        ),
      );
    }

    return tabs;
  }
}