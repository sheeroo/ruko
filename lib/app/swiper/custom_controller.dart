import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSwiperController extends AppinioSwiperController {
  CustomSwiperController() : super();

  bool _isControlledSwiping = false;
  bool _unswipping = false;

  bool get isControlledSwiping => _isControlledSwiping;
  bool get isUnswipping => _unswipping;

  @override
  Future<void> unswipe() async {
    _unswipping = true;
    await super.unswipe();
    await Future.delayed(1.seconds);
    _unswipping = false;
  }

  @override
  Future<void> swipeLeft() async {
    _isControlledSwiping = true;
    await super.swipeLeft();
    await Future.delayed(1.seconds);
    _isControlledSwiping = false;
  }

  @override
  Future<void> swipeRight() async {
    _isControlledSwiping = true;
    await super.swipeLeft();
    await Future.delayed(1.seconds);
    _isControlledSwiping = false;
  }
}
