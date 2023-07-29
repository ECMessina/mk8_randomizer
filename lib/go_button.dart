import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/providers.dart';

class GoButton extends ConsumerWidget {
  const GoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.flag,
        size: 30,
        color: Colors.red,
      ),
      label: const Text(
        "GO!!!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 3, 9, 73)),
      ),
      onPressed: () {
        debugPrint("${ref.read(raceCountProvider.notifier).raceCount}");
      },
    );
  }
}
