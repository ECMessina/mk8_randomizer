import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/providers.dart';

class RaceCountRow extends ConsumerStatefulWidget {
  const RaceCountRow({Key? key}) : super(key: key);

  @override
  ConsumerState<RaceCountRow> createState() => _RaceCountRowState();
}

class _RaceCountRowState extends ConsumerState<RaceCountRow> {
  @override
  Widget build(BuildContext context) {
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

class RaceCountButton extends StatelessWidget {
  const RaceCountButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

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
