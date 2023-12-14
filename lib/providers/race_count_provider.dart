import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/shared_preferences_provider.dart';

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
    48,
  ];

  int _raceCountIndex = 0;

  @override
  int build() {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    var savedRaceCount = sharedPreferences.getInt(kRaceCountPreference) ?? _raceCounts[_raceCountIndex];

    return savedRaceCount;
  }

  void decrement() {
    if (_raceCountIndex != 0) {
      _raceCountIndex--;
    } else {
      _raceCountIndex = _raceCounts.length - 1;
    }

    state = _raceCounts[_raceCountIndex];

    _saveToSharedPreferences();
  }

  void increment() {
    if (_raceCountIndex != (_raceCounts.length - 1)) {
      _raceCountIndex++;
    } else {
      _raceCountIndex = 0;
    }

    state = _raceCounts[_raceCountIndex];

    _saveToSharedPreferences();
  }

  void _saveToSharedPreferences() async {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    await sharedPreferences.setInt(kRaceCountPreference, _raceCounts[_raceCountIndex]);
  }
}
