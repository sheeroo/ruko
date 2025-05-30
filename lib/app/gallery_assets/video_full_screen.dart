import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_delete_demo/app/gallery_assets/widget_zoom_fullscreen.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/widgets/common/video_player.dart';
import 'package:photo_manager/photo_manager.dart';

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
          zoomWidget: VideoPlayerWidget(entity: entity),
          minScale: 1,
          maxScale: 3,
          heroAnimationTag: entity.id,
          withDoubleTapZoom: false,
        ),
      ),
    ).blur(64);
  }
}
