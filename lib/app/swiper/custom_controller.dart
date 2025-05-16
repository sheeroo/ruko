import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_delete_demo/core/limiters/debouncer.dart';
import 'package:image_delete_demo/core/limiters/throttler.dart';

class CustomSwiperController extends AppinioSwiperController {
  CustomSwiperController() : super();

  bool _isControlledSwiping = false;
  int _deletedCount = 0;

  int get deletedCount => _deletedCount;

  void addDeleted(int value) {
    _deletedCount += value;
  }

  int get safeIndex {
    return (cardIndex ?? 0) - _deletedCount;
  }

  bool get isControlledSwiping => _isControlledSwiping;
  final debouncer = Debouncer(750.ms);
  final throttler = Throttler(550.ms);

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
    if (cardIndex == 0) {
      return;
    }
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
