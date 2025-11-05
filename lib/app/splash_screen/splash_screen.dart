import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ruko/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:ruko/core/bootstrap.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/text_extension.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      await Bootstrap.instance.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimation(
          onComplete: () async {
            await Bootstrap.instance.ensureInitialized;
            final status = await Permission.photos.status;
            if (status.isGranted) {
              if (!context.mounted) return;
              await context.read<GalleryAssetsCubit>().loadAssets();
              if (!context.mounted) return;
              context.router.replaceAll([HomeRoute()]);
            } else {
              if (!context.mounted) return;
              context.router.replaceAll([PermissionRequestRoute()]);
            }
          },
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({
    super.key,
    this.onComplete,
  });

  final void Function()? onComplete;

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  int get _length => 6;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children:
                [
                      ...List.generate(_length, (index) => index).map(
                        (index) {
                          return Container(
                            color: Colors.white,
                            height: 28,
                            width: 28,
                          );
                        },
                      ),
                    ]
                    .animate(
                      onComplete: (_) {
                        HapticFeedback.lightImpact();
                        setState(() {
                          counter++;
                        });
                        if (counter == _length) {
                          widget.onComplete?.call();
                        }
                      },
                      interval: 125.ms,
                    )
                    .fadeIn(
                      duration: 125.ms,
                      delay: 200.ms,
                    ),
          ),
        ),
        Text(
          "loading assets ${((counter / _length) * 100).round()}%",
        ).bodySmall(fontSize: 9.7, opacity: 0.5),
      ],
    );
  }
}
