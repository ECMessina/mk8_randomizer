import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/race_count_provider.dart';
import 'package:mk8_randomizer/providers/race_details_provider.dart';
import 'package:mk8_randomizer/screens/alert_popup.dart';
import 'package:mk8_randomizer/screens/races_selected.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_row.dart';
import 'package:mk8_randomizer/widgets/track_grid_view.dart';

class TrackSelection extends ConsumerWidget {
  const TrackSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  onPressed: () async {
                    var raceCountSelected = ref.read(raceCountProvider);
                    var raceSelections = ref.read(raceDetailsProvider);
                    var raceList = <String>[];

                    for (
                      int cupIndex = 0;
                      cupIndex < raceSelections.cups.length;
                      cupIndex++
                    ) {
                      for (
                        int trackIndex = 0;
                        trackIndex <
                            raceSelections.cups[cupIndex].tracks.length;
                        trackIndex++
                      ) {
                        if (raceSelections
                            .cups[cupIndex]
                            .tracks[trackIndex]
                            .selected) {
                          raceList.add('${cupIndex + 1}-${trackIndex + 1}');
                        }
                      }
                    }

                    var proceed = true;

                    if (raceList.isEmpty || raceList.length == 1) {
                      proceed = await showDialog(
                        context: context,
                        builder:
                            (context) => AlertPopup(
                              contentText:
                                  raceList.isEmpty
                                      ? 'No tracks, no race!'
                                      : 'Can\'t shuffle, no race!',
                              buttonOnPressed1: () {
                                Navigator.pop(context, false);
                              },
                              buttonText1: 'Choose tracks',
                            ),
                      );
                    } else if (raceList.length < raceCountSelected) {
                      proceed = await showDialog(
                        context: context,
                        builder:
                            (context) => AlertPopup(
                              contentText: '100% chance of duplicates!',
                              buttonOnPressed1: () {
                                Navigator.pop(context, true);
                              },
                              buttonText1: 'It\'s okay',
                              buttonOnPressed2: () {
                                Navigator.pop(context, false);
                              },
                              buttonText2: 'Rethink',
                            ),
                      );
                    }

                    if (!proceed) {
                      return;
                    }

                    var shortRaceList = <String>[];

                    do {
                      do {
                        raceList.shuffle();
                      } while (shortRaceList.lastOrNull == raceList.first);

                      shortRaceList.addAll(raceList);
                    } while (shortRaceList.length < raceCountSelected);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => RacesSelected(
                              finalRaceList: shortRaceList.sublist(
                                0,
                                raceCountSelected,
                              ),
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
