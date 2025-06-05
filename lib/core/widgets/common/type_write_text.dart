import 'package:collection/collection.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatableText {
  const AnimatableText({
    required this.text,
    required this.delay,
    required this.deleteDelay,
  });
  final String text;
  final Duration delay;
  final Duration deleteDelay;

  AnimatableText copyWith({
    String? text,
    Duration? delay,
    Duration? deleteDelay,
  }) {
    return AnimatableText(
      text: text ?? this.text,
      delay: delay ?? this.delay,
      deleteDelay: deleteDelay ?? this.deleteDelay,
    );
  }
}

class TypeWriterText extends StatefulWidget {
  const TypeWriterText({
    super.key,
    required this.texts,
    this.onComplete,
    this.center = false,
  });
  final void Function(BuildContext)? onComplete;
  final List<AnimatableText> texts;
  final bool center;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  late AnimatableText _text = widget.texts.first;
  late int _listIndex = 0;
  int _index = 0;
  late bool _animationFinished = false;
  void resetAnimation() async {
    if (_listIndex == widget.texts.length - 1) {
      widget.onComplete?.call(context);
      return;
    }
    _listIndex = _listIndex + 1;
    _text = widget.texts[_listIndex];
    _index = 0;
    _animationFinished = false;

    await Future.delayed(_text.delay);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final chars = _text.text.split('');

    return Stack(
      children: [
        if (!_animationFinished)
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment:
                  widget.center ? WrapAlignment.center : WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              key: ValueKey(_text),
              children: [
                    ...chars.map((char) {
                      if (char == '\n') {
                        return const SizedBox(width: double.infinity);
                      }
                      return Text(char).bodySmall();
                    }),
                  ]
                  .animate(delay: Durations.medium1, interval: Durations.short1)
                  .fadeIn(
                    duration: Durations.medium2,
                    curve: Curves.fastOutSlowIn,
                  )
                  .moveY(
                    duration: Durations.medium1,
                    begin: 10,
                    end: 0,
                    curve: Curves.fastOutSlowIn,
                  )
                  .listen(
                    callback: (value) {
                      if (value > 0.4 && value < 0.6) {
                        HapticFeedback.lightImpact();
                      }
                    },
                  )
                  .callback(
                    callback: (value) {
                      _index++;
                      if (_index == chars.length) {
                        setState(() {
                          _animationFinished = true;
                        });
                      }
                    },
                  ),
            ),
          ),
        if (_animationFinished)
          DeleteTextAnimation(
            text: _text.text,
            delay: _text.deleteDelay,
            center: widget.center,
            onComplete: () {
              resetAnimation();
            },
          ),
      ],
    );
  }
}

class DeleteTextAnimation extends StatefulWidget {
  const DeleteTextAnimation({
    super.key,
    required this.text,
    required this.delay,
    this.onComplete,
    this.center = false,
  });

  final String text;
  final Duration delay;
  final void Function()? onComplete;
  final bool center;

  @override
  State<DeleteTextAnimation> createState() => _DeleteTextAnimationState();
}

class _DeleteTextAnimationState extends State<DeleteTextAnimation> {
  late int _index = widget.text.length - 1;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await Future.delayed(widget.delay);
      if (mounted) {
        setState(() {
          ready = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chars = widget.text.split('');
    return RepaintBoundary(
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: widget.center ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children:
              chars.mapIndexed((charIndex, e) {
                final animatable =
                    e == '\n'
                        ? const SizedBox(width: double.infinity)
                        : Text(e).bodySmall();
                return animatable
                    .animate(
                      target: _index <= charIndex && ready ? 1 : 0,
                      onComplete: (controller) {
                        if (controller.value == 1) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _index--;
                            if (_index == 0) {
                              widget.onComplete?.call();
                            }
                          });
                        }
                      },
                    )
                    .fadeOut(
                      duration: decay(15, _index).ms,
                      curve: Curves.fastOutSlowIn,
                    );
              }).toList(),
        ),
      ),
    );
  }
}

double decay(double value, int index) {
  final decay = index / 100;
  return (value - (value * decay)).clamp(15, value);
}
