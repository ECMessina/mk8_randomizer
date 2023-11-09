import 'package:flutter/material.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/widgets/action_button.dart';
import 'package:mk8_randomizer/widgets/race_count_button.dart';

class RacesSelected extends StatelessWidget {
  const RacesSelected({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
