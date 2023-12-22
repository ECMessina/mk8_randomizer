import 'package:flutter/material.dart';

class RaceCountButton extends StatelessWidget {
  const RaceCountButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: const Icon(
        Icons.double_arrow,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}
