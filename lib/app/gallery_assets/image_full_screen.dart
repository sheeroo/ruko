import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_delete_demo/app/gallery_assets/widget_zoom_fullscreen.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

@RoutePage()
class ImageFullPage extends StatelessWidget {
  const ImageFullPage({super.key, required this.entity, required this.option});

  final AssetEntity entity;
  final ThumbnailOption option;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.75),
      body: SafeArea(
        child: WidgetZoomFullscreen(
          zoomWidget: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: AssetEntityImage(
              entity,
              fit: BoxFit.contain,
              thumbnailSize: ThumbnailSize(720, 1560),
            ),
          ),
          minScale: 1,
          maxScale: 3,
          heroAnimationTag: entity.id,
        ),
      ),
    ).blur(64);
  }
}
