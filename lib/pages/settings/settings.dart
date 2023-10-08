import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

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
              FractionallySizedBox(
                widthFactor: 0.95,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[100],
                  ),
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.95,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            elevation: const MaterialStatePropertyAll<double>(0),
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple.shade100),
                          ),
                          icon: const Icon(Icons.person),
                          label: const Text('Войти')
                        ),
                      ),
                    ],
                  )
                ),
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