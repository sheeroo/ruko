import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// An effect that animates a blur on the target between the
/// specified [begin] and [end] blur radiuses (via [ImageFiltered]).
/// Defaults to `begin=0, end=4`.
@immutable
class CustomBlurEffect extends Effect<Offset> {
  static const Offset neutralValue = Offset(neutralBlur, neutralBlur);
  static const Offset defaultValue = Offset(defaultBlur, defaultBlur);

  static const double neutralBlur = 0.0;
  static const double defaultBlur = 64.0;
  static const double minBlur = 0.01;

  const CustomBlurEffect({
    super.delay,
    super.duration,
    super.curve,
    Offset? begin,
    Offset? end,
  }) : super(
          begin: begin ?? neutralValue,
          end: end ?? (begin == null ? defaultValue : neutralValue),
        );

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
    EffectEntry entry,
  ) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return getOptimizedBuilder<Offset>(
      animation: animation,
      builder: (_, __) {
        final double sigmaX = _normalizeSigma(animation.value.dx);
        final double sigmaY = _normalizeSigma(animation.value.dy);
        bool enabled = sigmaX > minBlur || sigmaY > minBlur;
        return ImageFiltered(
          enabled: enabled,
          imageFilter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
            tileMode: TileMode.decal,
          ),
          child: child,
        );
      },
    );
  }

  double _normalizeSigma(double sigma) {
    // Initially added to address a Flutter issue where near-zero blurs caused RTEs.
    // https://github.com/flutter/engine/pull/36575
    // This has been fixed, but now blurs with a zero value cause visual issues on macOS.
    return sigma < minBlur ? minBlur : sigma;
  }
}

/// Adds [CustomBlurEffect] related extensions to [AnimateManager].
extension CustomBlurEffectExtensions<T extends AnimateManager<T>> on T {
  /// Adds a [CustomBlurEffect] that animates a blur on the target between
  /// the specified [begin] and [end] blur radiuses (via [ImageFiltered]).
  T customBlur({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    Offset? begin,
    Offset? end,
  }) =>
      addEffect(CustomBlurEffect(
        delay: delay,
        duration: duration,
        curve: curve,
        begin: begin,
        end: end,
      ));
}
