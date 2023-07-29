import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/go_button.dart';
import 'package:mk8_randomizer/race_count_row.dart';
import 'package:mk8_randomizer/track_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 5, 8, 170),
                  Color.fromARGB(255, 5, 119, 139),
                ],
              ),
            ),
            child: const Column(
              children: [
                RaceCountRow(),
                TrackGridView(),
                GoButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
