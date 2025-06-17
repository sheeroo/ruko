import 'package:flutter/material.dart';

class TimeBuilder extends StatefulWidget {
  const TimeBuilder({
    super.key,
    required this.builder,
  });
  final Widget Function(BuildContext context, double time) builder;
  @override
  State<TimeBuilder> createState() => _TimeBuilderState();
}

class _TimeBuilderState extends State<TimeBuilder> {
  final ValueNotifier<double> _timeNotifier = ValueNotifier(0.0);
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.microtask(() async {
      while (mounted) {
        await Future.delayed(const Duration(milliseconds: 16));
        _timeNotifier.value += 0.016;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _timeNotifier,
      builder: (context, time, child) => widget.builder(context, time),
    );
  }
}
