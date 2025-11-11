import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/image_full_screen.dart';
import 'package:ruko/app/gallery/widget_zoom_fullscreen.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/widgets/common/video_player.dart';

@RoutePage()
class VideoFullPage extends StatelessWidget {
  const VideoFullPage({super.key, required this.entity});

  final AssetEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.75),
      body: SafeArea(
        child: WidgetZoomFullscreen(
          zoomWidget: Stack(
            children: [
              Center(child: VideoPlayerWidget(entity: entity)),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: ShareButtons(entity: entity, isVideo: true)
                      .p(all: 12)
                      .animate()
                      .fadeIn(
                        duration: Durations.medium3,
                        curve: Curves.fastOutSlowIn,
                      ),
                ),
              ),
            ],
          ),
          minScale: 1,
          maxScale: 3,
          heroAnimationTag: entity.id,
          withDoubleTapZoom: false,
        ),
      ),
    ).blur(64);
  }
}
