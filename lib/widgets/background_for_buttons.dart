import 'package:flutter/material.dart';

class BackgroundForButtons extends StatelessWidget {
  const BackgroundForButtons({
    super.key,
    this.children,
  });

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple[100],
        ),
        child: Column(
          children: children!
        )
      ),
    );
  }
}