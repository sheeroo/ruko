import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/app/swiper/custom_controller.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/text_extension.dart';

class ImageItemWidget extends StatefulWidget {
  const ImageItemWidget({
    super.key,
    required this.entity,
    required this.option,
    required this.controller,
    required this.index,
  });

  final CustomSwiperController controller;
  final int index;
  final AssetEntity entity;
  final ThumbnailOption option;

  @override
  State<ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  bool hapticDispatched = false;
  final appinioSocialShare = AppinioSocialShare();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.cardIndex != widget.index) return;
      final progress = widget.controller.position?.progress ?? 0;
      if (progress > 0.10) {
        if (!hapticDispatched) {
          if (!widget.controller.isControlledSwiping) {
            HapticFeedback.selectionClick();
          }
          hapticDispatched = true;
        }
      } else {
        hapticDispatched = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.entity.id,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          if (widget.entity.type == AssetType.video) {
            context.router.push(VideoFullRoute(entity: widget.entity));
            return;
          }
          context.router.push(
            ImageFullRoute(entity: widget.entity, option: widget.option),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: Colors.white,
              width: 3,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.black),
                AssetEntityImage(
                  widget.entity,
                  isOriginal: false,
                  thumbnailSize: widget.option.size,
                  thumbnailFormat: widget.option.format,
                  errorBuilder: (_, __, ___) {
                    return Center(
                      child: Container(
                        color: Colors.black,
                        child: Text("error loading image!"),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),

                if (widget.entity.type == AssetType.video)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Pixel.play, size: 24),
                    ),
                  ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 325,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.65),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 325,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.25),
                          ],
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                                "delete!!",
                                style: TextTheme.of(
                                  context,
                                ).displaySmall?.copyWith(fontSize: 18),
                              )
                              .animate(
                                adapter: ChangeNotifierAdapter(
                                  widget.controller,
                                  () {
                                    if (widget.controller.isControlledSwiping) {
                                      return 0;
                                    }
                                    if (widget.controller.cardIndex ==
                                        widget.index) {
                                      if ((widget
                                                  .controller
                                                  .position
                                                  ?.offset
                                                  .dx ??
                                              0) <
                                          0) {
                                        return widget
                                                .controller
                                                .position!
                                                .progress *
                                            6;
                                      }
                                    }
                                    return 0;
                                  },
                                ),
                              )
                              .fadeIn(),
                        ],
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                                "keep",
                                style: TextTheme.of(
                                  context,
                                ).displaySmall?.copyWith(fontSize: 18),
                              )
                              .animate(
                                adapter: ChangeNotifierAdapter(
                                  widget.controller,
                                  () {
                                    if (widget.controller.isControlledSwiping) {
                                      return 0;
                                    }
                                    if (widget.controller.cardIndex ==
                                        widget.index) {
                                      if ((widget
                                                  .controller
                                                  .position
                                                  ?.offset
                                                  .dx ??
                                              0) >
                                          0) {
                                        return widget
                                                .controller
                                                .position!
                                                .progress *
                                            6;
                                      }
                                    }
                                    return 0;
                                  },
                                ),
                              )
                              .fadeIn(),
                        ],
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(color: Colors.black),
                        child: Text(
                          widget.entity.createDateTime.format("dd/MM/yyyy"),
                        ).bodySmall(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
