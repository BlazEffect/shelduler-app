import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'package:scheduler/blocks/AppNavigationBar.dart';

List<String> titles = <String>[
  'Мои цели',
  'Общие цели',
  'Заметки',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: "mysql-8.0",
      port: 3306,
      userName: "root",
      password: "1234",
      databaseName: "shelduler-mobile", // optional
    );

    await conn.connect();

    return conn;
  }

  Future<Iterable<ResultSetRow>> getTasks() async {
    final conn = await getConnection();
    final results = await conn.execute('SELECT * FROM tasks');
    return results.rows;
  }

  List<Widget> createTaskItems(Iterable<ResultSetRow> rowTasks) {
    List<Widget> tasks = <Widget>[];

    for(var rowTask in rowTasks) {
      String name = rowTask.assoc()['name'] ?? '';

      tasks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.deepPurple[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(name)
            ),
          )
        )
      );
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    return FutureBuilder(
      future: getTasks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final tasks = createTaskItems(snapshot.data);

        return DefaultTabController(
          initialIndex: 0,
          length: tabsCount,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 1;
              },
              scrolledUnderElevation: 4.0,
              shadowColor: Theme.of(context).shadowColor,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: const Icon(Icons.cloud_outlined),
                    text: titles[0],
                  ),
                  Tab(
                    icon: const Icon(Icons.list),
                    text: titles[1],
                  ),
                  Tab(
                    icon: const Icon(Icons.edit),
                    text: titles[2],
                  ),
                ],
              ),
            ),
            body: ListView(
                padding: const EdgeInsets.all(20),
                children: tasks
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {},
                tooltip: 'Create',
                shape: const CircleBorder(),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add)
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const AppNavigationBar(
              fabLocation: FloatingActionButtonLocation.centerDocked,
              shape: CircularNotchedRectangle(),
            ),
          )
        );
      }
    );
  }
}