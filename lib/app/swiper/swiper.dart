import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/asset_entity_image.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/image_delete_cubit.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

class AssetSwiper extends StatefulWidget {
  const AssetSwiper({
    super.key,
    required this.assets,
    required this.controller,
  });

  final List<AssetEntity> assets;
  final AppinioSwiperController controller;

  @override
  State<AssetSwiper> createState() => _AssetSwiperState();
}

class _AssetSwiperState extends State<AssetSwiper> {
  late final controller = widget.controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              spacing: 24,
              children: [
                Flexible(
                  child: AppinioSwiper(
                    key: ValueKey(widget.assets),
                    controller: controller,
                    swipeOptions: SwipeOptions.symmetric(
                      horizontal: true,
                      vertical: false,
                    ),
                    duration: 175.ms,
                    onSwipeEnd: (targetIndex, nextIndex, activity) {
                      if (activity.end != null && activity.end!.dx != 0) {
                        if (activity.direction == AxisDirection.left) {
                          context.read<ImageDeleteCubit>().add(
                            widget.assets[targetIndex],
                          );
                        }
                      }
                    },
                    backgroundCardCount: 4,
                    backgroundCardOffset: Offset(25, 25),
                    cardBuilder: (BuildContext context, int index) {
                      final asset = widget.assets[index % widget.assets.length];
                      return ImageItemWidget(
                        entity: asset,
                        index: index,
                        option: ThumbnailOption.ios(
                          size: ThumbnailSize(720, 1560),
                        ),
                        controller: controller,
                      );
                    },
                    cardCount: widget.assets.length,
                  ).animate().fadeIn(
                    curve: Curves.fastOutSlowIn,
                    duration: 650.ms,
                  ),
                ),
                Row(
                  spacing: 24,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: StyledButton.filled(
                        title: "delete",
                        fullWidth: true,
                        onPressed: () {
                          controller.swipeLeft();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(color: Colors.white, offset: Offset(3, 3)),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Pixel.cornerdownright,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          HapticFeedback.lightImpact();
                          if (controller.cardIndex == null) return;
                          if (controller.cardIndex! == 0) return;
                          await controller.unswipe();
                          if (!context.mounted) {
                            return;
                          }
                          context.read<ImageDeleteCubit>().remove(
                            widget.assets[controller.cardIndex!],
                          );
                        },
                      ),
                    ),

                    Flexible(
                      child: StyledButton.filled(
                        title: "keep",
                        fullWidth: true,
                        onPressed: () {
                          controller.swipeRight();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ).fallback(const SizedBox.shrink(), when: widget.assets.isEmpty),
      ),
    );
  }
}
