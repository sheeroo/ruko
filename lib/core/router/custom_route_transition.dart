import 'package:flutter/material.dart';

Widget fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  final dialogScaleTween = Tween<double>(begin: 1.3, end: 1.0)
      .chain(CurveTween(curve: Curves.linearToEaseOut));
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: animation.drive(dialogScaleTween),
      child: child,
    ),
  );
}
