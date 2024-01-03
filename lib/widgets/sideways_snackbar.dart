import 'package:flutter/material.dart';

class SidewaysSnackBar {
  static void show(BuildContext context, String message) {
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _SidewaysSnackBar(
        message: message,
        overlayEntry: overlayEntry!,
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

class _SidewaysSnackBar extends StatefulWidget {
  const _SidewaysSnackBar({
    required this.message,
    required this.overlayEntry,
  });

  final String message;
  final OverlayEntry overlayEntry;

  @override
  State<_SidewaysSnackBar> createState() => _SidewaysSnackBarState();
}

class _SidewaysSnackBarState extends State<_SidewaysSnackBar> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    var restoreAnimationSequence = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(-1.0, 0),
          end: const Offset(0, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(const Offset(0, 0)),
        weight: 3,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0, 0),
          end: const Offset(1.0, 0),
        ),
        weight: 1,
      )
    ]);

    offsetAnimation = restoreAnimationSequence.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward().then((value) => widget.overlayEntry.remove());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.centerLeft,
          color: const Color.fromARGB(255, 247, 187, 5),
          width: MediaQuery.of(context).size.width,
          height: 47,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              widget.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
