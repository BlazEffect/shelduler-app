import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    this.shape = const CircularNotchedRectangle(),
  });

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: IconButton(
                tooltip: 'Home page',
                icon: const Icon(Icons.home),
                onPressed: () {
                  if (route != null && route.settings.name != '/') {
                    Navigator.pushNamed(context, '/');
                  }
                },
              )
            ),
            Expanded(
              child: IconButton(
                tooltip: 'Search page',
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (route != null && route.settings.name != '/search') {
                    Navigator.pushNamed(context, '/search');
                  }
                },
              )
            ),
            const Expanded(child: Text('')),
            Expanded(
              child: IconButton(
                tooltip: 'Calendar page',
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  if (route != null && route.settings.name != '/calendar') {
                    Navigator.pushNamed(context, '/calendar');
                  }
                },
              )
            ),
            Expanded(
              child: IconButton(
                tooltip: 'Settings page',
                icon: const Icon(Icons.settings),
                onPressed: () {
                  if (route != null && route.settings.name != '/settings') {
                    Navigator.pushNamed(context, '/settings');
                  }
                },
              )
            )
          ],
        ),
      ),
    );
  }
}