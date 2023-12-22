import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/shared_preferences_provider.dart';
import 'package:mk8_randomizer/screens/races_selected.dart';
import 'package:mk8_randomizer/screens/track_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final sharedPreferences = await SharedPreferences.getInstance();

  var raceListSaved = sharedPreferences.getStringList(kFinalRaceListSaved);
  var raceIndexSaved = sharedPreferences.getInt(kFinalRaceIndexSaved);
  var inProgressCup = false;

  if (raceListSaved != null && raceIndexSaved != null) {
    if (raceIndexSaved == raceListSaved.length - 1) {
      await sharedPreferences.remove(kFinalRaceListSaved);
      await sharedPreferences.remove(kFinalRaceIndexSaved);
    } else {
      inProgressCup = true;
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MainApp(
        inProgressCup: inProgressCup,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.inProgressCup});

  final bool inProgressCup;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: !inProgressCup ? const TrackSelection() : const RacesSelected(),
    );
  }
}
