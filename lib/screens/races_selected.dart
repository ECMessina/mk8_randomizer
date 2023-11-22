import 'package:flutter/material.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/screens/alert_popup.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_button.dart';

class RacesSelected extends StatelessWidget {
  const RacesSelected({super.key, required this.finalRaceList});

  final List<String> finalRaceList;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
          barrierDismissible: false,
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: kBackgroundDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scaleX: -1,
                      child: RaceCountButton(onPressed: () {}),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      child: const Text(
                        'Race 1 of 1',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    RaceCountButton(onPressed: () {}),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.55,
                        child: Image.asset(
                          "images/4.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Image.asset("images/4-1.png"),
                    ],
                  ),
                ),
                ActionButton(
                  icon: Icons.alt_route,
                  text: "Restart",
                  onPressed: () {
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
                      barrierDismissible: false,
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
