import 'package:flutter/material.dart';

import 'package:scheduler/blocks/AppNavigationBar.dart';

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
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    elevation: 5.0,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text('Войти')
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      )
    );
  }

}