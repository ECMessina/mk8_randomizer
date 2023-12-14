import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/shared_preferences_provider.dart';

final raceDetailsProvider = NotifierProvider<RaceDetailsNotifier, RaceDetails>(RaceDetailsNotifier.new);

class RaceDetailsNotifier extends Notifier<RaceDetails> {
  @override
  RaceDetails build() {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    var savedRaceDetailsJson = sharedPreferences.getString(kRaceDetailsPreference);

    if (savedRaceDetailsJson == null) {
      return RaceDetails();
    }

    var savedRaceDetails = RaceDetails.fromJson(jsonDecode(savedRaceDetailsJson));
    return savedRaceDetails;
  }

  void toggleSelection(int cupIndex, int? trackIndex) {
    if (trackIndex != null) {
      state.cups[cupIndex].tracks[trackIndex].toggleSelection();
      state.cups[cupIndex].checkTracks();
    } else {
      state.cups[cupIndex].toggleSelection();
    }

    state = RaceDetails.copy(
      cups: state.cups,
    );

    _saveToSharedPreferences();
  }

  void _saveToSharedPreferences() async {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    var savedRaceDetails = jsonEncode(state);
    await sharedPreferences.setString(kRaceDetailsPreference, savedRaceDetails);
  }
}

class RaceDetails {
  RaceDetails() {
    for (int x = 0; x < 24; x++) {
      cups.add(Cup());
    }
  }

  RaceDetails.copy({
    required this.cups,
  });

  List<Cup> cups = [];

  Map<String, dynamic> toJson() => {
        'cups': cups.map((cup) => cup.toJson()).toList()
      };

  RaceDetails.fromJson(Map<String, dynamic> json) {
    cups = json['cups'].map<Cup>((cup) => Cup.fromJson(cup)).toList();
  }
}

class Cup {
  Cup() {
    for (int x = 0; x < 4; x++) {
      tracks.add(Track());
    }
  }

  bool selected = true;
  List<Track> tracks = [];

  void toggleSelection() {
    selected = !selected;

    for (int x = 0; x < tracks.length; x++) {
      tracks[x].selected = selected;
    }
  }

  void checkTracks() {
    var selectedTracks = tracks.where((track) => track.selected).toList();
    // Following code shows a few other ways to get selected tracks
    // var selectedTracks2 = tracks.where((track) => track.selected == true).toList();
    // var selectedTracks3 = tracks.where((track) {
    //   return track.selected == true;
    // }).toList();
    // var selectedTracks4 = tracks.where((track) {
    //   if (track.selected) {
    //     return true;
    //   }
    //   else {
    //     return false;
    //   }
    // }).toList();

    if (selectedTracks.isEmpty) {
      selected = false;
    } else {
      selected = true;
    }
  }

  Map<String, dynamic> toJson() => {
        'selected': selected,
        'tracks': tracks.map((track) => track.toJson()).toList()
      };

  Cup.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    tracks = json['tracks'].map<Track>((track) => Track.fromJson(track)).toList();
  }
}

class Track {
  bool selected = true;

  Track();

  void toggleSelection() {
    selected = !selected;
  }

  Map<String, dynamic> toJson() => {
        'selected': selected
      };

  Track.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
  }
}
