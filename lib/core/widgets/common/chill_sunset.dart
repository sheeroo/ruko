import 'package:ruko/core/widgets/common/time_builder.dart';
import 'package:ruko/core/widgets/glitched_shader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SunShaderWidget extends StatefulWidget {
  const SunShaderWidget({super.key});

  @override
  State<SunShaderWidget> createState() => _SunShaderWidgetState();
}

class _SunShaderWidgetState extends State<SunShaderWidget> {
  int tappedCounter = 0;
  bool get warning => tappedCounter > 12;
  bool get glitched => tappedCounter >= 23;
  String get warningText {
    if (glitched) {
      return 'ok your broke it :)';
    }
    return 'stop tapping you gonna break it';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.heavyImpact();
        setState(() {
          tappedCounter = 0;
        });
      },
      onTap: () {
        HapticFeedback.heavyImpact();
        setState(() {
          tappedCounter = tappedCounter + 1;
        });
      },
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Glitched(
                when: glitched,
                child: TimeBuilder(
                  builder: (context, time) {
                    return ShaderBuilder(
                      assetKey: 'shaders/sun_shader.frag',
                      (context, shader, child) {
                        return AnimatedSampler((image, size, canvas) {
                          shader
                            ..setFloat(0, size.width) // iResolution.x
                            ..setFloat(1, size.height) // iResolution.y
                            ..setFloat(2, time); // iTime
                          canvas.drawRect(
                            Rect.fromLTWH(0, 0, size.width, size.height),
                            Paint()..shader = shader,
                          );
                        }, child: child!);
                      },
                      child: SizedBox(width: 250, height: 250),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
