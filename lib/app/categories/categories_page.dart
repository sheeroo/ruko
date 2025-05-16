import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/router/router.dart';
import 'package:image_delete_demo/core/theme/text_extension.dart';
import 'package:image_delete_demo/core/widgets/custom_appbar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final entries =
        context.watch<GalleryAssetsCubit>().state.groupedBySecond.entries;

    return Scaffold(
      appBar: CustomAppbar(title: "similar"),
      extendBody: true,
      body: SafeArea(
        top: false,
        child: GridView.builder(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries.elementAt(index);
            final asset = entry.value.first;
            final second = entry.value.elementAtOrNull(1);

            final date = entry.value.first.createDateTime;
            final month = date.format('MMMM');
            final day = date.format('dd');
            final year = date.format('yyyy');

            return PhotosCard(
              asset: asset,
              secondary: second,
              assets: entry.value,
              title: "$month $day",
              subtitle: year,
            ).p(all: 12);
          },
        ),
      ),
    );
  }
}

class PhotosCard extends StatelessWidget {
  const PhotosCard({
    super.key,
    required this.asset,
    required this.secondary,
    required this.assets,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;
  final AssetEntity? secondary;
  final AssetEntity asset;
  final List<AssetEntity> assets;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        context.router.push(
          CategoriesSwiperRoute(
            ids: assets.map((e) => e.id).toList(),
            title: "",
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (secondary != null)
            Transform.rotate(
              angle: -0.05,
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
            alignment: Alignment.topRight,
            child: Text(
              "(${assets.length})",
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
              Text(title ?? "").titleSmall(fontSize: 16),
              Text(subtitle ?? "").bodySmall(fontSize: 12, opacity: 0.75),
            ],
          ).p(horizontal: 6, vertical: 2),
        ],
      ),
    );
  }
}
