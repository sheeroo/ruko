import 'package:ruko/core/widgets/common/time_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class CrtShader extends StatelessWidget {
  const CrtShader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: TimeBuilder(
        builder:
            (context, time) => ShaderBuilder((context, shader, _) {
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
              }, child: child);
            }, assetKey: 'shaders/crt_shader.frag'),
      ),
    );
  }
}
