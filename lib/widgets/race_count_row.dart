import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/providers/race_count_provider.dart';
import 'package:mk8_randomizer/widgets/race_count_button.dart';

class RaceCountRow extends ConsumerWidget {
  const RaceCountRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raceCount = ref.watch(raceCountProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scaleX: -1,
          child: RaceCountButton(
            onPressed: () => ref.read(raceCountProvider.notifier).decrement(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 100,
          child: Text(
            "$raceCount Races",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        RaceCountButton(
          onPressed: () => ref.read(raceCountProvider.notifier).increment(),
        ),
      ],
    );
  }
}
