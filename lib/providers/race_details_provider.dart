import 'dart:convert';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/models.dart';
import 'package:mk8_randomizer/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'race_details_provider.g.dart';

@riverpod
class RaceDetails extends _$RaceDetails {
  @override
  RaceDetailsModel build() {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    var savedRaceDetailsJson = sharedPreferences.getString(
      kRaceDetailsPreference,
    );

    if (savedRaceDetailsJson == null) {
      return RaceDetailsModel();
    }

    var savedRaceDetails = RaceDetailsModel.fromJson(
      jsonDecode(savedRaceDetailsJson),
    );
    return savedRaceDetails;
  }

  void toggleSelection(int cupIndex, int? trackIndex) {
    if (trackIndex != null) {
      state.cups[cupIndex].tracks[trackIndex].toggleSelection();
      state.cups[cupIndex].checkTracks();
    } else {
      state.cups[cupIndex].toggleSelection();
    }

    state = RaceDetailsModel.copy(cups: state.cups);

    _saveToSharedPreferences();
  }

  void _saveToSharedPreferences() async {
    var sharedPreferences = ref.read(sharedPreferencesProvider);
    var savedRaceDetails = jsonEncode(state);
    await sharedPreferences.setString(kRaceDetailsPreference, savedRaceDetails);
  }
}
