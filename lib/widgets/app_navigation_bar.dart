import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);

    return BottomAppBar(
      shape: shape,
      height: 65,
      color: Colors.deepPurple,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: 'Home page',
              icon: const Icon(Icons.home),
              onPressed: () {
                if (route != null && route.settings.name != '/') {
                  Navigator.pushNamed(context, '/');
                }
              },
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
              tooltip: 'Search page',
              icon: const Icon(Icons.search),
              onPressed: () {
                if (route != null && route.settings.name != '/search') {
                  Navigator.pushNamed(context, '/search');
                }
              },
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
              tooltip: 'Calendar page',
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                if (route != null && route.settings.name != '/calendar') {
                  Navigator.pushNamed(context, '/calendar');
                }
              },
            ),
            IconButton(
              tooltip: 'Settings page',
              icon: const Icon(Icons.settings),
              onPressed: () {
                if (route != null && route.settings.name != '/settings') {
                  Navigator.pushNamed(context, '/settings');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}