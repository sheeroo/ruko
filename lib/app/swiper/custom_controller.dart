import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_delete_demo/core/limiters/debouncer.dart';

class CustomSwiperController extends AppinioSwiperController {
  CustomSwiperController() : super();

  bool _isControlledSwiping = false;

  bool get isControlledSwiping => _isControlledSwiping;
  final debouncer = Debouncer(750.ms);

  void setControlledSwiping(bool value) async {
    if (value) {
      _isControlledSwiping = true;
      return;
    }
    debouncer.run(() {
      _isControlledSwiping = false;
    });
  }

  @override
  Future<void> unswipe() async {
    setControlledSwiping(true);
    await super.unswipe();
    setControlledSwiping(false);
  }

  @override
  Future<void> swipeLeft() async {
    setControlledSwiping(true);
    await super.swipeLeft();
    setControlledSwiping(false);
  }

  @override
  Future<void> swipeRight() async {
    setControlledSwiping(true);
    await super.swipeRight();
    setControlledSwiping(false);
  }
}
