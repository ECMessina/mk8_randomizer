import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  const AlertPopup({
    super.key,
    required this.contentText,
    required this.buttonText1,
    this.buttonText2,
    required this.buttonOnPressed1,
    this.buttonOnPressed2,
  });

  final String contentText;
  final String buttonText1;
  final String? buttonText2;
  final Function() buttonOnPressed1;
  final Function()? buttonOnPressed2;

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
      content: Text(
        contentText,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: buttonOnPressed1,
                child: Text(
                  buttonText1,
                ),
              ),
            ),
            if (buttonText2 != null && buttonOnPressed2 != null)
              Expanded(
                child: TextButton(
                  onPressed: buttonOnPressed2,
                  child: Text(
                    buttonText2!,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
