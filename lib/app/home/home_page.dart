import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/asset_entity_image.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/home/trash_button.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:image_delete_demo/cubit/image_delete_cubit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = AppinioSwiperController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final assets = context.watch<GalleryAssetsCubit>().state.assets;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrashButton(
              onDelete: (ids) {
                setState(() {
                  assets.removeWhere((asset) => ids.contains(asset.id));
                });
                controller.setCardIndex(controller.cardIndex! - ids.length);
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(color: Colors.white, offset: Offset(2, 2)),
                ],
              ),
              child: IconButton(
                icon: const Icon(Pixel.arrowleft, color: Colors.white),
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  if (controller.cardIndex == null) return;
                  if (controller.cardIndex! == 0) return;
                  await controller.unswipe();
                  context.read<ImageDeleteCubit>().remove(
                    assets[controller.cardIndex!],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                spacing: 24,
                children: [
                  Flexible(
                    child: AppinioSwiper(
                      key: ValueKey(assets),
                      controller: controller,
                      loop: true,
                      swipeOptions: SwipeOptions.symmetric(
                        horizontal: true,
                        vertical: false,
                      ),
                      onSwipeEnd: (targetIndex, nextIndex, activity) {
                        if (activity.end != null && activity.end!.dx != 0) {
                          if (activity.direction == AxisDirection.left) {
                            context.read<ImageDeleteCubit>().add(
                              assets[targetIndex],
                            );
                          }
                        }
                      },
                      backgroundCardCount: 4,
                      backgroundCardOffset: Offset(25, 25),
                      cardBuilder: (BuildContext context, int index) {
                        final asset = assets[index % assets.length];
                        return ImageItemWidget(
                          entity: asset,
                          index: index,
                          option: ThumbnailOption.ios(
                            size: ThumbnailSize(720, 1560),
                          ),
                          controller: controller,
                        );
                      },
                      cardCount: assets.length,
                    ).animate().fadeIn(
                      curve: Curves.fastOutSlowIn,
                      duration: 650.ms,
                    ),
                  ),
                  Row(
                    spacing: 32,
                    children: [
                      Flexible(
                        child: StyledButton.filled(
                          title: "delete",
                          onPressed: () {
                            controller.swipeLeft();
                          },
                        ),
                      ),
                      Flexible(
                        child: StyledButton.filled(
                          title: "keep",
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
          ),
        ),
      ),
    );
  }
}
