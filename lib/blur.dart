import 'dart:ui';

import 'package:flutter/material.dart';

extension BlurX on Widget {
  ClipRRect blur(double sigma, {double? borderRadius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: this,
      ),
    );
  }
}
