import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

Route<T> modalSheetBuilder<T>(
        BuildContext context, Widget child, AutoRoutePage<T> page) =>
    CupertinoModalSheetRoute(
      settings: page,
      swipeDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      swipeDismissSensitivity: const SwipeDismissSensitivity(
        minDragDistance: double.infinity,
        minFlingVelocityRatio: 1,
      ),
      builder: (context) => child,
    );

Route<T> transparentRouteBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return PageRouteBuilder<T>(
    opaque: false,
    settings: page,
    fullscreenDialog: true,
    pageBuilder: (context, _, __) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      var tween = Tween(begin: begin, end: end);
      var fadeAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
  );
}
