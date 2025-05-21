import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/widgets/common/video_player.dart';
import 'package:image_delete_demo/core/widgets/custom_appbar.dart';
import 'package:photo_manager/photo_manager.dart';

@RoutePage()
class VideoFullPage extends StatelessWidget {
  const VideoFullPage({super.key, required this.entity});

  final AssetEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.black.withValues(alpha: 0.75),
      body: SafeArea(child: VideoPlayerWidget(entity: entity)),
    ).blur(64);
  }
}
