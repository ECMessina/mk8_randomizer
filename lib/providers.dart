import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceCountProvider = NotifierProvider<RaceCountNotifier, int>(RaceCountNotifier.new);

class RaceCountNotifier extends Notifier<int> {
  final _raceCounts = [
    4,
    6,
    8,
    12,
    16,
    24,
    32,
    48
  ];

  int _raceCountIndex = 0;

  int get raceCount => state;

  @override
  int build() {
    return _raceCounts[_raceCountIndex];
  }

  void decrement() {
    if (_raceCountIndex != 0) {
      _raceCountIndex--;
    } else {
      _raceCountIndex = _raceCounts.length - 1;
    }

    state = _raceCounts[_raceCountIndex];
  }

  void increment() {
    if (_raceCountIndex != (_raceCounts.length - 1)) {
      _raceCountIndex++;
    } else {
      _raceCountIndex = 0;
    }

    state = _raceCounts[_raceCountIndex];
  }
}
