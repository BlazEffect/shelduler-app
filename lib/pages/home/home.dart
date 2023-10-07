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
  late final TabController _tabController;

  void updateState() {
    setState(() {});
  }

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
    return FutureBuilder(
      future: TaskModel().getAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.task_alt),
                  text: 'Задачи',
                ),
                Tab(
                  icon: Icon(Icons.folder_outlined),
                  text: 'Группы',
                ),
                Tab(
                  icon: Icon(Icons.star_outline),
                  text: 'Избранное',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TaskTab(taskData: snapshot.data, updateDeleteState: updateState),
              // Temporary display of the same information on all tabs
              TaskTab(taskData: snapshot.data, updateDeleteState: updateState),
              TaskTab(taskData: snapshot.data, updateDeleteState: updateState)
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
    );
  }
}