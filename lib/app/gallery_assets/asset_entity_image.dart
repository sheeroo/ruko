import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
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
  late bool isFavorite = widget.entity.isFavorite;
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
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  if (widget.entity.type == AssetType.video) {
                    context.router.push(
                      VideoFullRoute(entity: widget.entity),
                    );
                    return;
                  }
                  context.router.push(
                    ImageFullRoute(
                      entity: widget.entity,
                      option: widget.option,
                    ),
                  );
                },
                child: AssetEntityImage(
                  widget.entity,
                  isOriginal: false,
                  thumbnailSize: widget.option.size,
                  thumbnailFormat: widget.option.format,
                  errorBuilder: (_, __, ___) {
                    return FutureBuilder(
                      future: widget.entity.thumbnailData,
                      builder: (context, asyncSnapshot) {
                        final data = asyncSnapshot.data;
                        if (data != null) {
                          return Image.memory(data, fit: BoxFit.cover);
                        }
                        return Center(
                          child: Container(
                            color: Colors.black,
                            child: Text("error loading image!"),
                          ),
                        );
                      },
                    );
                  },
                  fit: BoxFit.cover,
                ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            isFavorite = !isFavorite;
                            PhotoManager.editor.darwin.favoriteAsset(
                              entity: widget.entity,
                              favorite: isFavorite,
                            );
                          });
                        },
                        icon: SvgPicture.string(
                          isFavorite ? filledHeartSvg : emptyHeartSvg,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String filledHeartSvg = '''
<?xml version="1.0" encoding="UTF-8"?><svg fill="#ffffff" id="heart-solid" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><polygon points="23 6 23 11 22 11 22 12 21 12 21 13 20 13 20 14 19 14 19 15 18 15 18 16 17 16 17 17 16 17 16 18 15 18 15 19 14 19 14 20 13 20 13 21 11 21 11 20 10 20 10 19 9 19 9 18 8 18 8 17 7 17 7 16 6 16 6 15 5 15 5 14 4 14 4 13 3 13 3 12 2 12 2 11 1 11 1 6 2 6 2 5 3 5 3 4 4 4 4 3 10 3 10 4 11 4 11 5 13 5 13 4 14 4 14 3 20 3 20 4 21 4 21 5 22 5 22 6 23 6"/></svg>
''';
const String emptyHeartSvg = '''
<?xml version="1.0" encoding="UTF-8"?><svg fill="#ffffff" id="heart" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="m22,6v-1h-1v-1h-1v-1h-6v1h-1v1h-2v-1h-1v-1h-6v1h-1v1h-1v1h-1v5h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v1h1v1h2v-1h1v-1h1v-1h1v-1h1v-1h1v-1h1v-1h1v-1h1v-1h1v-1h1v-5h-1Zm-2,4v1h-1v1h-1v1h-1v1h-1v1h-1v1h-1v1h-1v1h-2v-1h-1v-1h-1v-1h-1v-1h-1v-1h-1v-1h-1v-1h-1v-1h-1v-3h1v-1h1v-1h4v1h1v1h1v1h2v-1h1v-1h1v-1h4v1h1v1h1v3h-1Z"/></svg>
''';

const String eyeSvg = '''
<?xml version="1.0" encoding="UTF-8"?><svg fill="#ffffff" id="eye" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><rect x="16" y="11" width="1" height="2"/><polygon points="16 13 16 15 15 15 15 16 13 16 13 15 14 15 14 14 15 14 15 13 16 13"/><polygon points="16 9 16 11 15 11 15 10 14 10 14 9 13 9 13 8 15 8 15 9 16 9"/><rect x="11" y="16" width="2" height="1"/><polygon points="11 15 11 16 9 16 9 15 8 15 8 13 9 13 9 14 10 14 10 15 11 15"/><polygon points="13 7 13 8 12 8 12 11 11 11 11 12 8 12 8 13 7 13 7 11 8 11 8 9 9 9 9 8 11 8 11 7 13 7"/><path d="m22,11v-2h-1v-1h-1v-1h-1v-1h-2v-1H7v1h-2v1h-1v1h-1v1h-1v2h-1v2h1v2h1v1h1v1h1v1h2v1h10v-1h2v-1h1v-1h1v-1h1v-2h1v-2h-1Zm-1,3h-1v1h-1v1h-1v1h-2v1h-8v-1h-1v-1h-2v-1h-1v-1h-1v-4h1v-1h1v-1h1v-1h2v-1h8v1h2v1h1v1h1v1h1v4Z"/></svg>
''';

const String eyeCrossedSvg = '''
<?xml version="1.0" encoding="UTF-8"?><svg fill="#ffffff" id="eye-cross" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><polygon points="15 13 16 13 16 15 15 15 15 16 13 16 13 15 14 15 14 14 15 14 15 13"/><rect x="16" y="11" width="1" height="2"/><polygon points="23 11 23 13 22 13 22 15 21 15 21 16 20 16 20 17 19 17 19 18 17 18 17 19 9 19 9 18 16 18 16 17 18 17 18 16 19 16 19 15 20 15 20 14 21 14 21 10 20 10 20 9 19 9 19 8 21 8 21 9 22 9 22 11 23 11"/><polygon points="2 13 1 13 1 11 2 11 2 9 3 9 3 8 4 8 4 7 5 7 5 6 7 6 7 5 15 5 15 6 8 6 8 7 6 7 6 8 5 8 5 9 4 9 4 10 3 10 3 14 4 14 4 15 5 15 5 16 3 16 3 15 2 15 2 13"/><polygon points="13 7 13 8 12 8 12 9 11 9 11 10 10 10 10 11 9 11 9 12 8 12 8 13 7 13 7 11 8 11 8 9 9 9 9 8 11 8 11 7 13 7"/><polygon points="9 17 8 17 8 18 7 18 7 19 6 19 6 20 5 20 5 21 4 21 4 22 3 22 3 21 2 21 2 20 3 20 3 19 4 19 4 18 5 18 5 17 6 17 6 16 7 16 7 15 8 15 8 14 9 14 9 13 10 13 10 12 11 12 11 11 12 11 12 10 13 10 13 9 14 9 14 8 15 8 15 7 16 7 16 6 17 6 17 5 18 5 18 4 19 4 19 3 20 3 20 2 21 2 21 3 22 3 22 4 21 4 21 5 20 5 20 6 19 6 19 7 18 7 18 8 17 8 17 9 16 9 16 10 15 10 15 11 14 11 14 12 13 12 13 13 12 13 12 14 11 14 11 15 10 15 10 16 9 16 9 17"/><rect x="11" y="16" width="2" height="1"/></svg>
''';
