import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';
import 'package:scheduler/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  setState(() {});
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
    return FutureBuilder(
      future: TaskModel().getAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final tasks = createTaskItems(snapshot.data);

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
              ListView(
                padding: const EdgeInsets.all(20),
                children: tasks
              ),
              // Temporary display of the same information on all tabs
              ListView(
                padding: const EdgeInsets.all(20),
                children: tasks
              ),
              ListView(
                padding: const EdgeInsets.all(20),
                children: tasks
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
    );
  }
}