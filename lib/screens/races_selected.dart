import 'package:flutter/material.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/screens/alert_popup.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_button.dart';

class RacesSelected extends StatefulWidget {
  const RacesSelected({super.key, required this.finalRaceList});

  final List<String> finalRaceList;

  @override
  State<RacesSelected> createState() => _RacesSelectedState();
}

class _RacesSelectedState extends State<RacesSelected> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  var finalRaceIndex = 0;

  final trackController = PageController();

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: kCupAnimationDuration),
      vsync: this,
    )..repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void showRestartPopup() {
    if (finalRaceIndex != widget.finalRaceList.length - 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertPopup(
          contentText: 'Waving a white flag already? This will start you over!',
          buttonOnPressed1: () {
            Navigator.pop(context);
          },
          buttonText1: 'Keep Racing',
          buttonOnPressed2: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          buttonText2: 'Reselect Races',
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertPopup(
          contentText: 'You did it!',
          buttonOnPressed1: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          buttonText1: 'Start new tour',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showRestartPopup();
        return false;
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
                        'Race ${finalRaceIndex + 1} of ${widget.finalRaceList.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Visibility(
                      visible: finalRaceIndex < widget.finalRaceList.length - 1,
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
                    itemCount: widget.finalRaceList.length,
                    controller: trackController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int trackInFinal) {
                      setState(() {
                        finalRaceIndex = trackInFinal;
                      });
                    },
                    itemBuilder: (context, activeTrackIndex) {
                      var splitFinalRaceImage = widget.finalRaceList[activeTrackIndex].split("-");
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
                                  animation: _animationController,
                                  builder: (context, widget) => Transform.rotate(
                                    angle: _animationController.value * kCupRotationAngle * -2,
                                    child: Image.asset(
                                      "images/$activeCup.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Image.asset("images/${widget.finalRaceList[activeTrackIndex]}.png"),
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
