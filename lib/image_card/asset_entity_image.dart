import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_delete_demo/utils.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ImageItemWidget extends StatelessWidget {
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
            Container(color: Colors.black),
            AssetEntityImage(
              entity,
              isOriginal: false,
              thumbnailSize: option.size,
              thumbnailFormat: option.format,
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
                      Colors.black.withValues(alpha: 1),
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
                          "delete",
                          style: TextTheme.of(
                            context,
                          ).displaySmall?.copyWith(fontSize: 18),
                        )
                        .animate(
                          adapter: ChangeNotifierAdapter(controller, () {
                            if (controller.cardIndex == index) {
                              if ((controller.position?.offset.dx ?? 0) < 0) {
                                return controller.position!.progress * 6;
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
                          adapter: ChangeNotifierAdapter(controller, () {
                            if (controller.cardIndex == index) {
                              if ((controller.position?.offset.dx ?? 0) > 0) {
                                return controller.position!.progress * 6;
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
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 0,
                        offset: Offset(3, 3),
                      ),
                    ],
                    color: Colors.black,
                  ),
                  child: Text(entity.createDateTime.format("dd/MM/yyyy")),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         // todo add auto router and open image with photo view
            //       },
            //       child: Container(
            //         padding: EdgeInsets.all(4),
            //         child: Icon(FeatherIcons.maximize),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
