import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TextSwapper extends StatefulWidget {
  const TextSwapper(this.text, {super.key, this.textAlign, this.style});

  final TextAlign? textAlign;
  final String text;
  final TextStyle? style;

  @override
  State<TextSwapper> createState() => _TextSwapperState();
}

class _TextSwapperState extends State<TextSwapper> {
  late String text = widget.text;
  String? incomingText;

  @override
  void didUpdateWidget(TextSwapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text == widget.text) return;
    setState(() {
      incomingText = widget.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Text(text, textAlign: widget.textAlign, style: widget.style)
          .animate(target: incomingText == null ? 0 : 1)
          .fadeOut(duration: 350.ms, curve: Curves.fastOutSlowIn)
          .moveY(
            duration: 350.ms,
            curve: Curves.fastOutSlowIn,
            begin: 0,
            end: 10,
          )
          .swap(
            builder: (context, value) {
              return TextSwapper(
                    incomingText ?? text,
                    textAlign: widget.textAlign,
                    style: widget.style,
                  )
                  .animate()
                  .fadeIn(
                    duration: Durations.short4,
                    curve: Curves.fastOutSlowIn,
                  )
                  .moveY(
                    begin: -10,
                    end: 0,
                    duration: Durations.short4,
                    curve: Curves.fastOutSlowIn,
                  );
            },
          ),
    );
  }
}
