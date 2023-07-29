import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class TrackGridView extends StatelessWidget {
  const TrackGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DynamicHeightGridView(
        itemCount: 22,
        crossAxisCount: 2,
        builder: (context, index) {
          return Column(
            children: [
              TrackSelectionImage(
                imageNumber: "${index + 1}",
                widthFactor: 0.55,
              ),
              for (int x = 1; x <= 4; x++) TrackSelectionImage(imageNumber: "${index + 1}-$x"),
            ],
          );
        },
      ),
    );
  }
}

class TrackSelectionImage extends StatelessWidget {
  const TrackSelectionImage({
    Key? key,
    this.widthFactor,
    required this.imageNumber,
  }) : super(key: key);

  final double? widthFactor;
  final String imageNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Image.asset(
          "images/$imageNumber.png",
        ),
      ),
    );
  }
}
