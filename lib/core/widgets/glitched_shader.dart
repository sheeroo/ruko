import 'package:ruko/core/widgets/common/time_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Glitched extends StatefulWidget {
  const Glitched({super.key, required this.child, required this.when});

  final bool when;
  final Widget child;

  @override
  State<Glitched> createState() => _GlitchedState();
}

class _GlitchedState extends State<Glitched> {
  @override
  Widget build(BuildContext context) {
    return TimeBuilder(
      builder:
          (context, time) => ShaderBuilder((context, shader, child) {
            if (!widget.when) {
              return widget.child;
            }
            return AnimatedSampler((image, size, canvas) {
              shader.setImageSampler(0, image);
              shader
                ..setFloat(0, size.width)
                ..setFloat(1, size.height)
                ..setFloat(2, time)
                ..setImageSampler(0, image);

              canvas.drawRect(
                Rect.fromLTWH(0, 0, size.width, size.height),
                Paint()..shader = shader,
              );
            }, child: widget.child);
          }, assetKey: 'shaders/glitch_shader.frag'),
    );
  }
}
