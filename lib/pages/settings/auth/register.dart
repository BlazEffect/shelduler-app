import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              }
            );
          },
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      )
    );
  }
}