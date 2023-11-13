import 'package:flutter/material.dart';
import 'package:mk8_randomizer/screens/track_selection.dart';

class AlertPopup extends StatelessWidget {
  const AlertPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      title: const Text(
        'Hold up!',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Waving a white flag already? This will start you over!',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Keep Racing',
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Reselect Races',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
