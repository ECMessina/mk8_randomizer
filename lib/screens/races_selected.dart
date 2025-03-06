import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/shared_preferences_provider.dart';
import 'package:mk8_randomizer/screens/alert_popup.dart';
import 'package:mk8_randomizer/screens/track_selection.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_button.dart';
import 'package:mk8_randomizer/widgets/sideways_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RacesSelected extends ConsumerStatefulWidget {
  const RacesSelected({super.key, this.finalRaceList});

  final List<String>? finalRaceList;

  @override
  ConsumerState<RacesSelected> createState() => _RacesSelectedState();
}

class _RacesSelectedState extends ConsumerState<RacesSelected>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final SharedPreferences sharedPreferences;
  late final List<String> finalRaceList;
  late final PageController trackController;

  var finalRaceIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: kCupAnimationDuration),
      vsync: this,
    )..repeat(reverse: true);

    sharedPreferences = ref.read(sharedPreferencesProvider);

    if (widget.finalRaceList == null) {
      finalRaceList = sharedPreferences.getStringList(kFinalRaceListSaved)!;
      finalRaceIndex = sharedPreferences.getInt(kFinalRaceIndexSaved)!;

      WidgetsBinding.instance.addPostFrameCallback((duration) {
        SidewaysSnackBar.show(context, "Data loaded from previous session");
      });
    } else {
      finalRaceList = widget.finalRaceList!;
      sharedPreferences.setStringList(kFinalRaceListSaved, finalRaceList);
      sharedPreferences.setInt(kFinalRaceIndexSaved, finalRaceIndex);
    }

    trackController = PageController(initialPage: finalRaceIndex);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showRestartPopup() {
    if (finalRaceIndex != finalRaceList.length - 1) {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertPopup(
              contentText:
                  'Waving a white flag already? This will start you over!',
              buttonText1: 'Keep Racing',
              buttonOnPressed1: () {
                Navigator.pop(context);
              },
              buttonText2: 'Reselect Races',
              buttonOnPressed2: returnToTrackSelection,
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertPopup(
              contentText: 'You did it!',
              buttonText1: 'Start new tour',
              buttonOnPressed1: returnToTrackSelection,
            ),
      );
    }
  }

  void returnToTrackSelection() {
    sharedPreferences.remove(kFinalRaceListSaved);
    sharedPreferences.remove(kFinalRaceIndexSaved);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TrackSelection()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }

        showRestartPopup();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: kBackgroundDecoration,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: finalRaceIndex > 0,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: Transform.scale(
                        scaleX: -1,
                        child: RaceCountButton(
                          onPressed: () {
                            trackController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInBack,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      child: Text(
                        'Race ${finalRaceIndex + 1} of ${finalRaceList.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: finalRaceIndex < finalRaceList.length - 1,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: RaceCountButton(
                        onPressed: () {
                          trackController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: finalRaceList.length,
                    controller: trackController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int trackInFinal) async {
                      await sharedPreferences.setInt(
                        kFinalRaceIndexSaved,
                        trackInFinal,
                      );

                      setState(() {
                        finalRaceIndex = trackInFinal;
                      });
                    },
                    itemBuilder: (context, activeTrackIndex) {
                      var splitFinalRaceImage = finalRaceList[activeTrackIndex]
                          .split("-");
                      var activeCup = splitFinalRaceImage[0];

                      return FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FractionallySizedBox(
                              widthFactor: kCupWidthFactor,
                              child: Transform.rotate(
                                angle: kCupRotationAngle,
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  builder:
                                      (context, widget) => Transform.rotate(
                                        angle:
                                            animationController.value *
                                            kCupRotationAngle *
                                            -2,
                                        child: Image.asset(
                                          "images/$activeCup.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Image.asset(
                              "images/${finalRaceList[activeTrackIndex]}.png",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ActionButton(
                  icon: Icons.alt_route,
                  text: "Restart",
                  onPressed: showRestartPopup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
