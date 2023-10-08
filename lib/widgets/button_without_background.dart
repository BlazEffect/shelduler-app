import 'package:flutter/material.dart';

class ButtonWithoutBackground extends StatelessWidget {
  const ButtonWithoutBackground({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label
  });

  final VoidCallback onPressed;
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: ElevatedButton.icon(
        onPressed: onPressed,
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
        icon: icon,
        label: label
      ),
    );
  }
}