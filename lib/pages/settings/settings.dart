import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';
import 'package:scheduler/widgets/background_for_buttons.dart';
import 'package:scheduler/widgets/button_without_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Настройки'),
            ),
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
          ),
          SliverList.list(
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              BackgroundForButtons(
                children: [
                  ButtonWithoutBackground(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Войти')
                  ),
                ],
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      )
    );
  }
}