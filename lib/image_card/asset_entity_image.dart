import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.index == widget.controller.cardIndex) {
        // swiped left
        print(widget.controller.position?.offset.dx);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AssetEntityImage(
              widget.entity,
              isOriginal: false,
              thumbnailSize: widget.option.size,
              thumbnailFormat: widget.option.format,
              fit: BoxFit.cover,
            ),

            Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.5),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "swiping left",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .animate(
                  adapter: ChangeNotifierAdapter(widget.controller, () {
                    if (widget.controller.cardIndex == widget.index) {
                      if ((widget.controller.position?.offset.dx ?? 0) < 0) {
                        return widget.controller.position!.progress;
                      }
                    }
                    return 0;
                  }),
                )
                .fadeIn(),
            Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.5),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "swiping right",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .animate(
                  adapter: ChangeNotifierAdapter(widget.controller, () {
                    if (widget.controller.cardIndex == widget.index) {
                      if ((widget.controller.position?.offset.dx ?? 0) > 0) {
                        return widget.controller.position!.progress;
                      }
                    }
                    return 0;
                  }),
                )
                .fadeIn(),
          ],
        ),
      ),
    );
  }
}
