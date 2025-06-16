import 'dart:async';

import 'package:flutter/material.dart';

class DurationProgressController {
  DurationProgressController({required this.duration});
  final Duration duration;
  late Timer _timer;
  double _progress = 0.0;
  bool _isRunning = false;
  void Function()? onComplete;
  final _progressStreamController = StreamController<double>();

  Stream<double> get progressStream => _progressStreamController.stream;

  void startProgress() {
    if (_isRunning) return;

    _isRunning = true;
    final updateInterval =
        Duration(milliseconds: 10); // Update every 50ms for smooth animation
    final steps = duration.inMilliseconds / updateInterval.inMilliseconds;
    final stepValue = 1.0 / steps;

    _timer = Timer.periodic(updateInterval, (timer) {
      if (_progress < 1.0) {
        _progress += stepValue;
        _progressStreamController.add(_progress);
      } else {
        _progress = 1.0;
        _progressStreamController.add(_progress);
        _timer.cancel();
        _isRunning = false;
        onComplete?.call();
      }
    });
  }

  void resetProgress() {
    _timer.cancel();
    _progress = 0.0;
    _progressStreamController.add(_progress);
    _isRunning = false;
  }

  void pauseProgress() {
    _timer.cancel();
    _isRunning = false;
  }

  void dispose() {
    _timer.cancel();
    _progressStreamController.close();
  }
}

class DurationProgressIndicator extends StatefulWidget {
  final DurationProgressController controller;
  final bool autoStart;

  const DurationProgressIndicator({
    super.key,
    required this.controller,
    this.autoStart = true,
  });

  @override
  State<DurationProgressIndicator> createState() =>
      _DurationProgressIndicatorState();
}

class _DurationProgressIndicatorState extends State<DurationProgressIndicator> {
  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      widget.controller.startProgress();
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.progressStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return LinearProgressIndicator(
          value: data,
          borderRadius: BorderRadius.circular(4),
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
