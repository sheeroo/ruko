import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/asset_entity_image.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/image_delete_cubit.dart';
import 'package:image_delete_demo/app/swiper/custom_controller.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/limiters/throttler.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:image_delete_demo/core/widgets/common/widgets/text_swapper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

class AssetSwiper extends StatefulWidget {
  const AssetSwiper({
    super.key,
    required this.assets,
    required this.controller,
  });

  final List<AssetEntity> assets;
  final CustomSwiperController controller;

  @override
  State<AssetSwiper> createState() => _AssetSwiperState();
}

class _AssetSwiperState extends State<AssetSwiper> {
  final throttler = Throttler(225.ms);
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageDeleteCubit(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                spacing: 24,
                children: [
                  Flexible(
                    child: AppinioSwiper(
                      controller: widget.controller,
                      swipeOptions: SwipeOptions.symmetric(
                        horizontal: true,
                        vertical: false,
                      ),
                      loop: true,
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
                        final asset =
                            widget.assets[index % widget.assets.length];
                        return ImageItemWidget(
                          entity: asset,
                          index: index,
                          option: ThumbnailOption.ios(
                            size: ThumbnailSize(720, 1560),
                          ),
                          controller: widget.controller,
                        );
                      },
                      cardCount: widget.assets.length,
                    ).animate().fadeIn(
                      curve: Curves.fastOutSlowIn,
                      duration: 850.ms,
                    ),
                  ),
                  Row(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: BlocBuilder<ImageDeleteCubit, ImageDeleteState>(
                          builder: (context, state) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                GestureDetector(
                                  onLongPress: () async {
                                    if (_deleting) return;
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _deleting = true;
                                    });
                                    final List<String> result =
                                        await PhotoManager.editor.deleteWithIds(
                                          state.entities
                                              .map((e) => e.id)
                                              .toList(),
                                        );
                                    if (!context.mounted) return;
                                    setState(() {
                                      _deleting = false;
                                    });
                                    if (result.isEmpty) {
                                      return;
                                    }
                                    context
                                        .read<GalleryAssetsCubit>()
                                        .removeAssets(
                                          state.entities
                                              .map((e) => e.id)
                                              .toList(),
                                        );
                                    widget.controller.setCardIndex(
                                      widget.controller.cardIndex! -
                                          result.length,
                                    );
                                    // controller.addDeleted(result.length);
                                    if (result.isNotEmpty && context.mounted) {
                                      context.read<ImageDeleteCubit>().reset();
                                    }
                                  },
                                  child: StyledButton.filled(
                                    title: "delete",
                                    isLoading: _deleting,
                                    fullWidth: true,
                                    onPressed: () {
                                      widget.controller.swipeLeft();
                                    },
                                  ),
                                ),
                                Positioned(
                                      right: -6,
                                      top: -6,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            ..."${state.entities.length}"
                                                .padLeft(2, '0')
                                                .split('')
                                                .map((char) {
                                                  return TextSwapper(
                                                    char,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    )
                                    .animate(
                                      target: state.entities.isNotEmpty ? 1 : 0,
                                    )
                                    .moveY(
                                      curve: Curves.fastOutSlowIn,
                                      begin: -20,
                                      end: 0,
                                    )
                                    .fadeIn(curve: Curves.fastOutSlowIn),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Pixel.cornerdownright,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            throttler.run(() async {
                              HapticFeedback.selectionClick();
                              if (widget.controller.cardIndex == null) return;
                              if (widget.controller.cardIndex! == 0) return;
                              await widget.controller.unswipe();
                              if (!context.mounted) {
                                return;
                              }
                              context.read<ImageDeleteCubit>().remove(
                                widget.assets[widget.controller.cardIndex!],
                              );
                            });
                          },
                        ),
                      ),

                      Flexible(
                        child: StyledButton.filled(
                          title: "keep",
                          fullWidth: true,
                          onPressed: () {
                            widget.controller.swipeRight();
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
      ),
    );
  }
}
