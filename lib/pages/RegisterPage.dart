import 'package:flutter/material.dart';

import 'package:scheduler/blocks/AppNavigationBar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        bottomNavigationBar: AppNavigationBar(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: CircularNotchedRectangle(),
        )
    );
  }
}