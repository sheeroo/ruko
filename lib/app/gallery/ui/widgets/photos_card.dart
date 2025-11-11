import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/text_extension.dart';

class PhotosCard extends StatelessWidget {
  const PhotosCard({
    super.key,
    required this.asset,
    required this.secondary,
    required this.length,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final String? title;
  final String? subtitle;
  final AssetEntity? secondary;
  final AssetEntity asset;
  final int length;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (secondary != null)
            Transform.rotate(
              angle: 0.02,
              child: Transform.translate(
                offset: const Offset(7, 7),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  child: AssetEntityImage(
                    asset,
                    isOriginal: false,
                    fit: BoxFit.cover,
                    thumbnailFormat: ThumbnailFormat.jpeg,
                    thumbnailSize: ThumbnailSize(720, 1560),
                  ),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                color: Colors.white,
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: AssetEntityImage(
              asset,
              isOriginal: false,
              fit: BoxFit.cover,
              thumbnailFormat: ThumbnailFormat.jpeg,
              thumbnailSize: ThumbnailSize(720, 1560),
            ),
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
            alignment: Alignment.topCenter,
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
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "($length)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ).bodySmall(fontSize: 10).p(all: 4),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (title != null) Text(title!).titleSmall(fontSize: 14),
              if (subtitle != null)
                Text(subtitle!).bodySmall(fontSize: 10, opacity: 0.75),
            ],
          ).p(horizontal: 6, vertical: 2),
        ],
      ),
    );
  }
}
