import 'dart:async';
import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ruko/app/gallery_assets/widget_zoom_fullscreen.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/button.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:pixelarticons/pixel.dart';

@RoutePage()
class ImageFullPage extends StatelessWidget {
  const ImageFullPage({super.key, required this.entity, required this.option});

  final AssetEntity entity;
  final ThumbnailOption option;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.5),
      body: WidgetZoomFullscreen(
        zoomWidget: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: AssetEntityImage(
                  entity,
                  fit: BoxFit.contain,
                  thumbnailSize: ThumbnailSize(720, 1560),
                ),
              ).p(all: 4, bottom: 72),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: ShareButtons(entity: entity, isVideo: false)
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
      ),
    ).blur(64);
  }
}

class ShareButtons extends StatefulWidget {
  const ShareButtons({super.key, required this.entity, required this.isVideo});

  final bool isVideo;
  final AssetEntity entity;

  @override
  State<ShareButtons> createState() => _ShareButtonsState();
}

class _ShareButtonsState extends State<ShareButtons> {
  File? file;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loadFile);
  }

  Future<void> _loadFile() async {
    final file = await widget.entity.originFile;
    if (mounted) {
      setState(() {
        this.file = file;
      });
    }
  }

  final _share = AppinioSocialShare();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children: [
            StyledButton.icon(
              isLoading: file == null,
              icon: FeatherIcons.instagram,
              onPressed: () {
                _share.iOS.shareToInstagramStory(
                  "955471519885440",
                  backgroundVideo: file!.path,
                );
              },
            ),
            StyledButton.icon(
              isLoading: file == null,
              icon: Pixel.upload,
              onPressed: () {
                _share.iOS.shareToSystem("yoooooo", filePaths: [file!.path]);
              },
            ),
          ]
          .animate(delay: Durations.medium1, interval: Durations.short1)
          .fadeIn(duration: Durations.medium3, curve: Curves.fastOutSlowIn)
          .moveY(
            duration: Durations.medium3,
            begin: 40,
            end: 0,
            curve: Curves.fastOutSlowIn,
          ),
    );
  }
}
