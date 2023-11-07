import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/providers/race_count_provider.dart';
import 'package:mk8_randomizer/providers/race_details_provider.dart';
import 'package:mk8_randomizer/races_selected.dart';

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RacesSelected()));

        // debugPrint("${ref.read(raceCountProvider)}");
        // debugPrint("${ref.read(raceCountProvider.notifier).raceCount}");

        // var raceDetails = ref.read(raceDetailsProvider);
        // List<String> trackList = [];

        // for (int cupIndex = 0; cupIndex < raceDetails.cups.length; cupIndex++) {
        //   for (int trackIndex = 0; trackIndex < raceDetails.cups[cupIndex].tracks.length; trackIndex++) {
        //     if (raceDetails.cups[cupIndex].tracks[trackIndex].selected) {
        //       trackList.add("${cupIndex + 1}-${trackIndex + 1}");
        //     }
        //   }
        // }

        // debugPrint(trackList.toString());
        // trackList.shuffle();
        // debugPrint(trackList.toString());
        // var shorterList = trackList.sublist(0, 4);
        // debugPrint(shorterList.toString());
      },
    );
  }
}
