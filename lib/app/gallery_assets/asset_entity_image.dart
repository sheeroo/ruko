import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/theme/text_extension.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ImageItemWidget extends StatefulWidget {
  const ImageItemWidget({
    super.key,
    required this.entity,
    required this.option,
    required this.controller,
    required this.index,
  });

  final AppinioSwiperController controller;
  final int index;
  final AssetEntity entity;
  final ThumbnailOption option;

  @override
  State<ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  bool hapticDispatched = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.cardIndex == widget.index) {
        if ((widget.controller.position?.progress ?? 0) > 0.15) {
          if (!hapticDispatched) {
            HapticFeedback.lightImpact();
            hapticDispatched = true;
          }
        } else {
          hapticDispatched = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [BoxShadow(color: Colors.white, offset: Offset(3, 3))],
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
              fit: BoxFit.cover,
            ),
            Align(
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
            Align(
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
                          adapter: ChangeNotifierAdapter(widget.controller, () {
                            if (widget.controller.cardIndex == widget.index) {
                              if ((widget.controller.position?.offset.dx ?? 0) <
                                  0) {
                                return widget.controller.position!.progress * 6;
                              }
                            }
                            return 0;
                          }),
                        )
                        .fadeIn(),
                  ],
                ),
              ),
            ),
            Align(
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
                          adapter: ChangeNotifierAdapter(widget.controller, () {
                            if (widget.controller.cardIndex == widget.index) {
                              if ((widget.controller.position?.offset.dx ?? 0) >
                                  0) {
                                return widget.controller.position!.progress * 6;
                              }
                            }
                            return 0;
                          }),
                        )
                        .fadeIn(),
                  ],
                ),
              ),
            ),
            Align(
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
          ],
        ),
      ),
    );
  }
}
