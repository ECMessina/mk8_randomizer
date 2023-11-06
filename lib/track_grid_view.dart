import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/providers/race_details_provider.dart';

class TrackGridView extends ConsumerWidget {
  const TrackGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raceDetails = ref.watch(raceDetailsProvider);

    return Expanded(
      child: DynamicHeightGridView(
        itemCount: raceDetails.cups.length,
        crossAxisCount: 2,
        builder: (context, index) {
          return Column(
            children: [
              TrackSelectionImage(
                imageNumber: "${index + 1}",
                widthFactor: 0.55,
              ),
              for (int x = 0; x < 4; x++)
                TrackSelectionImage(
                  imageNumber: "${index + 1}-${x + 1}",
                ),
            ],
          );
        },
      ),
    );
  }
}

class TrackSelectionImage extends ConsumerWidget {
  TrackSelectionImage({
    super.key,
    this.widthFactor,
    required this.imageNumber,
  }) {
    var splitImageNumber = imageNumber.split("-");
    cupIndex = int.parse(splitImageNumber[0]) - 1;
    trackIndex = splitImageNumber.length == 2 ? int.parse(splitImageNumber[1]) - 1 : null;
  }

  final double? widthFactor;
  final String imageNumber;
  late final int cupIndex;
  late final int? trackIndex;
  late bool isSelected;

  final normalColor = const ColorFilter.mode(Colors.transparent, BlendMode.saturation);
  final greyscale = const ColorFilter.matrix(
    [
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var raceDetails = ref.read(raceDetailsProvider);

    if (trackIndex == null) {
      isSelected = raceDetails.cups[cupIndex].selected;
    } else {
      isSelected = raceDetails.cups[cupIndex].tracks[trackIndex!].selected;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          ref.read(raceDetailsProvider.notifier).toggleSelection(cupIndex, trackIndex);
        },
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: ColorFiltered(
            colorFilter: isSelected ? normalColor : greyscale,
            child: Image.asset(
              "images/$imageNumber.png",
            ),
          ),
        ),
      ),
    );
  }
}
