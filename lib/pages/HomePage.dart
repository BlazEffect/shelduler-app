import 'package:flutter/material.dart';

import 'package:scheduler/blocks/AppNavigationBar.dart';

List<String> titles = <String>[
  'Мои цели',
  'Общие цели',
  'Заметки',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    return DefaultTabController(
        initialIndex: 1,
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
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
}