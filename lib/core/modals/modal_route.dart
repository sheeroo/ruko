import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class SmoothModalRoute extends CupertinoModalSheetRoute {
  SmoothModalRoute({
    required super.builder,
    SwipeDismissSensitivity? swipeDismissSensitivity,
    Color? barrierColor,
    super.swipeDismissible = true,
    super.settings,
    super.fullscreenDialog,
    super.maintainState,
    super.barrierDismissible,
    super.barrierLabel,
    super.transitionDuration,
    super.transitionCurve,
  }) : super(
          barrierColor: Colors.black.withValues(alpha: 0.75),
          swipeDismissSensitivity: swipeDismissSensitivity ??
              const SwipeDismissSensitivity(
                minDragDistance: double.infinity,
                minFlingVelocityRatio: 1,
              ),
        );
}
