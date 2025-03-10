import 'package:flutter/material.dart';

class AllButton extends StatelessWidget {
  const AllButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 30, color: color),
      onPressed: onPressed,
    );
  }
}
