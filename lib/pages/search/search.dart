import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
    );
  }
}