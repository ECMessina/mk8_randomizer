import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceDetailsProvider = NotifierProvider<RaceDetailsNotifier, RaceDetails>(RaceDetailsNotifier.new);

class RaceDetailsNotifier extends Notifier<RaceDetails> {
  @override
  RaceDetails build() {
    return RaceDetails();
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
}

class Track {
  bool selected = true;

  void toggleSelection() {
    selected = !selected;
  }
}
