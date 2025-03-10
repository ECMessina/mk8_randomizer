class RaceDetailsModel {
  RaceDetailsModel() {
    for (int x = 0; x < 24; x++) {
      cups.add(CupModel());
    }
  }

  RaceDetailsModel.copy({required this.cups});

  List<CupModel> cups = [];

  Map<String, dynamic> toJson() => {
    'cups': cups.map((cup) => cup.toJson()).toList(),
  };

  RaceDetailsModel.fromJson(Map<String, dynamic> json) {
    cups = json['cups'].map<CupModel>((cup) => CupModel.fromJson(cup)).toList();
  }
}

class CupModel {
  CupModel() {
    for (int x = 0; x < 4; x++) {
      tracks.add(TrackModel());
    }
  }

  bool selected = true;
  List<TrackModel> tracks = [];

  void updateAll(bool selectAll) {
    selected = selectAll;

    for (int x = 0; x < tracks.length; x++) {
      tracks[x].selected = selectAll;
    }
  }

  void toggleSelection() {
    selected = !selected;

    for (int x = 0; x < tracks.length; x++) {
      tracks[x].selected = selected;
    }
  }

  void checkTracks() {
    var selectedTracks = tracks.where((track) => track.selected).toList();

    if (selectedTracks.isEmpty) {
      selected = false;
    } else {
      selected = true;
    }
  }

  Map<String, dynamic> toJson() => {
    'selected': selected,
    'tracks': tracks.map((track) => track.toJson()).toList(),
  };

  CupModel.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    tracks =
        json['tracks']
            .map<TrackModel>((track) => TrackModel.fromJson(track))
            .toList();
  }
}

class TrackModel {
  bool selected = true;

  TrackModel();

  void toggleSelection() {
    selected = !selected;
  }

  Map<String, dynamic> toJson() => {'selected': selected};

  TrackModel.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
  }
}
