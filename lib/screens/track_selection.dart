import 'package:flutter/material.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/screens/races_selected.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_row.dart';
import 'package:mk8_randomizer/widgets/track_grid_view.dart';

class TrackSelection extends StatelessWidget {
  const TrackSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: kBackgroundDecoration,
          child: Column(
            children: [
              const RaceCountRow(),
              const TrackGridView(),
              ActionButton(
                icon: Icons.flag,
                text: "GO!!!",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RacesSelected(),
                    ),
                  );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
