import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:ruko/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

enum AssetCategory {
  month,
  nearby,
  screenshots,
  shuffle,
  videos,
  reversed,
}

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
    return Scaffold(
      appBar: CustomAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Gap(12)),
          ...AssetCategory.values.map((category) {
            final entries = context
                .watch<GalleryAssetsCubit>()
                .state
                .assets
                .fromCategory(category)
                .entries;
            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text("> ${category.name}").p(horizontal: 12),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      prototypeItem: SizedBox(height: 180, width: 180),
                      itemCount: entries.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final assets = entries.elementAt(index).value;
                        final secondary = assets.elementAtOrNull(1);
                        final date = assets.first.createDateTime;
                        final month = date.format('MMMM');
                        final year = date.format('yyyy');
                        return PhotosCard(
                          asset: assets[0],
                          secondary: secondary,
                          assets: assets,
                          title: month,
                          subtitle: year,
                        ).p(all: 12);
                      },
                    ),
                  ),
                ],
              ).p(bottom: 12),
            );
          }),
          SliverToBoxAdapter(child: SafeArea(child: Gap(0))),
        ],
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
            title: title ?? "",
          ),
        );
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
              Text(title ?? "").titleSmall(fontSize: 14),
              Text(subtitle ?? "").bodySmall(fontSize: 10, opacity: 0.75),
            ],
          ).p(horizontal: 6, vertical: 2),
        ],
      ),
    );
  }
}
