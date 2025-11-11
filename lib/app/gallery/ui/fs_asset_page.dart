import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:ruko/app/gallery/ui/widgets/asset_entity_image.dart';
import 'package:ruko/app/gallery/ui/widgets/share_buttons.dart';
import 'package:ruko/app/gallery/ui/widgets/widget_zoom_fullscreen.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/widgets/common/video_player.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class FSAssetPage extends StatefulWidget {
  const FSAssetPage({
    super.key,
    required this.entity,
    required this.option,
  });

  final AssetEntity entity;
  final ThumbnailOption option;

  @override
  State<FSAssetPage> createState() => FSPageState();
}

class FSPageState extends State<FSAssetPage> {
  Widget buildPreview() {
    if (widget.entity.type == AssetType.image) {
      return AssetEntityImage(
        widget.entity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            FallbackImage(thumbnailData: widget.entity.thumbnailData),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            return const SizedBox.shrink();
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child: child,
          );
        },
        thumbnailSize: ThumbnailSize(720, 1560),
      ).p(all: 4, bottom: 72).p(horizontal: 8);
    }
    if (widget.entity.type == AssetType.video) {
      return VideoPlayerWidget(entity: widget.entity);
    }
    throw Exception('Unsupported asset type: ${widget.entity.type}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.black,
      body: WidgetZoom(
        zoomWidget: Stack(
          children: [
            Center(
              child: buildPreview(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: ShareButtons(
                  entity: widget.entity,
                  isVideo: false,
                ).p(all: 12),
              ),
            ),
          ],
        ),
        minScale: 1,
        maxScale: 3,
        heroAnimationTag: widget.entity.id,
      ),
    );
  }
}
