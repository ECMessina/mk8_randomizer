import 'package:flutter/material.dart';

const kBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromARGB(255, 5, 8, 170),
      Color.fromARGB(255, 5, 119, 139),
    ],
  ),
);

const kRaceCountPreference = 'RaceCount Preference';
const kRaceDetailsPreference = 'RaceDetails Preference';

const kCupWidthFactor = 0.55;
const kCupRotationAngle = 0.1;
const kCupAnimationDuration = 2300;
