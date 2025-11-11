import 'dart:async';
import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/core/theme/button.dart';
import 'package:ruko/core/util/social_share.dart';

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

  void onPressed() {
    if (widget.isVideo) {
      _share.shareToInstagramStory(backgroundVideo: file?.path);
    } else {
      _share.shareToInstagramStory(backgroundImage: file?.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children:
          [
                StyledButton.icon(
                  isLoading: file == null,
                  icon: FeatherIcons.instagram,
                  onPressed: onPressed,
                ),
                StyledButton.icon(
                  isLoading: file == null,
                  icon: Pixel.upload,
                  onPressed: () {
                    _share.shareToSystem(file!.path);
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
