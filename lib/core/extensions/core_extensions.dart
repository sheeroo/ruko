import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

extension IntX on int {
  int lowerLimit(int limit) {
    return this <= limit ? limit : this;
  }

  int upperLimit(int limit) {
    return this >= limit ? limit : this;
  }
}

extension CoreExtensions<T> on T? {
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  R? let<R>(R? Function(T it) block) {
    final self = this;
    if (self == null) {
      return null;
    }
    return block(self);
  }

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  R letOrElse<R>(R? Function(T it) block, {required R defaultValue}) {
    final self = this;
    if (self == null) {
      return defaultValue;
    }
    return block(self) ?? defaultValue;
  }

  T withDefault(T defaultValue) {
    final self = this;
    if (self == null) {
      return defaultValue;
    }
    return self;
  }
}

extension CoreExtensions2<T> on T {
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  Y build<R, Y>(Y Function(T it) block) {
    final self = this;

    return block(self);
  }
}

extension WidgetExtension on Widget {
  ClipRRect blur(double sigma, {double? borderRadius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: this,
      ),
    );
  }

  Padding p({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Transform rotate(double angle, {Offset? origin}) {
    return Transform.rotate(angle: angle, origin: origin, child: this);
  }

  ClipRRect clipRRect({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? all ?? 0),
        topRight: Radius.circular(topRight ?? all ?? 0),
        bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
        bottomRight: Radius.circular(bottomRight ?? all ?? 0),
      ),
      child: this,
    );
  }

  Widget fallback(Widget fallback, {bool when = false}) {
    return when ? fallback : this;
  }
}

extension RowX on Row {
  Row sandwich(Widget cheese) {
    if (this.children.isEmpty) {
      return this;
    }
    final children =
        this.children
            .map((item) {
              return [item, cheese];
            })
            .reduce((value, element) => [...value, ...element])
            .toList()
          ..removeLast();
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

extension DateTimeX on DateTime {
  // String get prompt => 'at ${format('dd/MM/yyyy')} i have to';
  DateTime addMonths(int months) {
    int totalMonths = year * 12 + month - 1 + months;
    int newYear = totalMonths ~/ 12;
    int newMonth = totalMonths % 12 + 1;

    // Ensure the day doesn't exceed the last day of the new month
    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    int newDay = (day > lastDayOfNewMonth) ? lastDayOfNewMonth : day;

    return DateTime(
      newYear,
      newMonth,
      newDay,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  String timeRemaining() {
    final now = DateTime.now();
    final Duration difference = this.difference(now);

    if (difference.isNegative) {
      return 'Expired'; // Or any past date handling you prefer
    }

    final int totalMinutes = difference.inMinutes;

    if (totalMinutes < 1) {
      return 'Less than a minute';
    } else if (totalMinutes < 60) {
      return 'in ${totalMinutes}m';
    } else if (totalMinutes < 1440) {
      // 24*60 = 1440
      final int hours = totalMinutes ~/ 60;
      final int minutes = totalMinutes % 60;
      return minutes > 0 ? 'in ${hours}h ${minutes}m' : 'in ${hours}h';
    } else {
      final int days = difference.inDays;
      return 'in $days ${days.build((d) => d > 1 ? 'days' : 'day')}';
    }
  }

  String get dayMonthSeasonYear => "$dayMonth, $getSeasonAndYear";

  bool get isBeforeToday => isBefore(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  String get dayMonth => format('dd MMM').toLowerCase().build((string) {
    if (string[0] == '0') {
      return " ${string.substring(1)}";
    }
    return string;
  });
  String get getSeason {
    int month = this.month;

    if ((month >= 3 && month <= 5)) {
      return 'spring';
    } else if (month >= 6 && month <= 8) {
      return 'summer';
    } else if (month >= 9 && month <= 11) {
      return 'autumn';
    } else {
      return 'winter';
    }
  }

  String get getSeasonAndYear {
    int month = this.month;
    int year = this.year;

    if ((month >= 3 && month <= 5)) {
      return 'spring $year';
    } else if (month >= 6 && month <= 8) {
      return 'summer $year';
    } else if (month >= 9 && month <= 11) {
      return 'autumn $year';
    } else {
      return 'winter $year';
    }
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String format(String format) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }

  int get daysFromNow {
    final now = DateTime.now();
    final normalizedDate1 = DateTime(now.year, now.month, now.day, 12);
    final normalizedDate2 = DateTime(year, month, day, 12);

    final difference = normalizedDate2.difference(normalizedDate1).inDays;

    return difference;
  }

  String get toHumanReadable {
    final today = DateTime.now();
    final yearAgo = today.subtract(const Duration(days: 365));
    final threeMonthsAgo = today.subtract(const Duration(days: 60));
    final twoMonthsAgo = today.subtract(const Duration(days: 60));
    final monthAgo = today.subtract(const Duration(days: 30));
    final weekAgo = today.subtract(const Duration(days: 7));
    final yesterday = today.subtract(const Duration(days: 1));

    if (isSameDay(today)) {
      return 'Today';
    }
    if (isSameDay(yesterday)) {
      return 'Yesterday';
    }

    if (isBefore(yearAgo)) {
      return 'long long time ago';
    } else if (isBefore(threeMonthsAgo)) {
      return 'this year';
    } else if (isBefore(twoMonthsAgo)) {
      return 'about three months ago';
    } else if (isBefore(monthAgo)) {
      return 'two months ago';
    } else if (isBefore(weekAgo)) {
      return 'this month';
    } else if (isBefore(yesterday)) {
      return 'this week';
    }
    throw UnimplementedError('This date is not supported');
  }
}

extension StringX on String {
  Uri? get tryUri => Uri.tryParse(this);
  Uri get toUri => Uri.parse(this);
  String pluralize(int count) {
    if (count == 1) {
      return this;
    }
    return "${this}s";
  }
}

extension AnimatedText on Text {
  Widget get loop {
    var widget = this;
    return _AnimatedText(child: widget);
  }

  Widget get mask {
    var widget = this;
    return _MaskedText(child: widget);
  }
}

class _AnimatedText extends StatefulWidget {
  const _AnimatedText({required this.child});

  final Widget child;

  @override
  State<_AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<_AnimatedText> {
  final controller = ScrollController();
  final _animationSpeed = 10;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loopAnimation);
    controller.addListener(() => _loopAnimation());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Duration _calculateDurationFromTextLength() {
    final duration =
        (controller.position.maxScrollExtent / _animationSpeed) * 1000;
    return duration.milliseconds;
  }

  void _loopAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || !controller.hasClients) {
        return;
      }

      if (controller.position.atEdge) {
        await Future.delayed(const Duration(seconds: 2));
        if (!controller.hasClients) return;
        if (controller.position.pixels == 0) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: _calculateDurationFromTextLength(),
            curve: Curves.linear,
          );
        } else {
          controller.animateTo(
            0,
            duration: _calculateDurationFromTextLength(),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: widget.child,
      ),
    );
  }
}

class _MaskedText extends StatefulWidget {
  const _MaskedText({required this.child});

  final Widget child;

  @override
  State<_MaskedText> createState() => _MaskedTextState();
}

class _MaskedTextState extends State<_MaskedText> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.transparent, Colors.white],
            stops: [0.0, 0.6],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: widget.child,
      ),
    );
  }
}

class ScrollCheckerWidget extends StatefulWidget {
  const ScrollCheckerWidget({
    super.key,
    required this.controller,
    required this.builder,
  });

  final ScrollController controller;
  final Widget Function(bool isScrollable) builder;

  @override
  State<ScrollCheckerWidget> createState() => _ScrollCheckerWidgetState();
}

class _ScrollCheckerWidgetState extends State<ScrollCheckerWidget> {
  late final ScrollController _scrollController;
  late bool _isScrollable;

  @override
  void initState() {
    _scrollController = widget.controller;

    _isScrollable = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isScrollable = _scrollController.position.maxScrollExtent > 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(_isScrollable);
  }
}

extension SizedContext on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  /// Returns diagonal screen pixels
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Returns fraction (0-1) of screen width in pixels
  double widthPct(double fraction) => fraction * widthPx;

  /// Returns fraction (0-1) of screen height in pixels
  double heightPct(double fraction) => fraction * heightPx;
}

extension FileX on File {
  String get name => basename(path);
}

extension ListX<T> on List<T> {
  List<T> copyFirstWith(T oldItem, T newItem) {
    return map((e) => e == oldItem ? newItem : e).toList();
  }

  List<T> copyMatchWith({
    required bool Function(T) predicate,
    required T Function(T) newItem,
  }) {
    return map((e) => predicate(e) ? newItem(e) : e).toList();
  }
}
