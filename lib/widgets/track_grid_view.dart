import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mk8_randomizer/constants.dart';
import 'package:mk8_randomizer/providers/race_details_provider.dart';

class TrackGridView extends ConsumerStatefulWidget {
  const TrackGridView({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackGridView> createState() => _TrackGridViewState();
}

class _TrackGridViewState extends ConsumerState<TrackGridView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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

  @override
  Widget build(BuildContext context) {
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
                animationController: _animationController,
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
    required this.imageNumber,
    this.animationController,
  }) {
    var splitImageNumber = imageNumber.split("-");
    cupIndex = int.parse(splitImageNumber[0]) - 1;
    trackIndex = splitImageNumber.length == 2 ? int.parse(splitImageNumber[1]) - 1 : null;
  }

  final String imageNumber;
  final AnimationController? animationController;
  late final int cupIndex;
  late final int? trackIndex;
  late final bool isSelected;

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
          widthFactor: (trackIndex == null) ? kCupWidthFactor : null,
          child: ColorFiltered(
            colorFilter: isSelected ? normalColor : greyscale,
            child: (animationController == null)
                ? Image.asset(
                    "images/$imageNumber.png",
                  )
                : Transform.rotate(
                    angle: kCupRotationAngle,
                    child: AnimatedBuilder(
                      animation: animationController!,
                      builder: (context, widget) => Transform.rotate(
                        angle: animationController!.value * kCupRotationAngle * -2,
                        child: Image.asset(
                          "images/$imageNumber.png",
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
