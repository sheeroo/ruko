import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/app/categories/categories_page.dart';
import 'package:ruko/app/categories/categories_swiper_page.dart';
import 'package:ruko/app/gallery/cubit/gallery_assets_cubit.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});

  final AssetCategory category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final controller = ScrollController();
  List<AssetEntity> shuffled = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      if (widget.category == AssetCategory.shuffle) {
        final allAssets = [...context.read<GalleryAssetsCubit>().state.assets];
        final shuffled = allAssets..shuffle();
        setState(() {
          this.shuffled = shuffled;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.category) {
      case AssetCategory.month:
      case AssetCategory.nearby:
        final entries = context
            .watch<GalleryAssetsCubit>()
            .state
            .assets
            .fromCategory(widget.category)
            .entries;
        return Scaffold(
          appBar: CustomAppbar(title: widget.category.title),
          body: GridView.builder(
            controller: controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries.elementAt(index);
              final asset = entry.value.first;
              final second = entry.value.elementAtOrNull(1);

              final (title, subtitle) = asset.titleAndSubtitle(widget.category);

              return PhotosCard(
                title: title,
                subtitle: subtitle,
                asset: asset,
                secondary: second,
                length: entry.value.length,
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(
                    CategoriesSwiperRoute(
                      ids: entry.value.map((e) => e.id).toList(),
                      title: title,
                    ),
                  );
                },
              ).p(all: 12);
            },
          ),
        );
      case AssetCategory.shuffle:
        return CategoriesSwiperPage(
          ids: shuffled.map((e) => e.id).toList(),
          title: widget.category.title,
        );
      case AssetCategory.videos:
        final entries = context
            .watch<GalleryAssetsCubit>()
            .state
            .assets
            .fromCategory(widget.category)
            .entries;
        return CategoriesSwiperPage(
          ids: entries
              .map((e) => e.value)
              .expand((e) => e)
              .where((element) => element.type == AssetType.video)
              .map((e) => e.id)
              .toList(),
          title: widget.category.title,
        );
      case AssetCategory.reversed:
        return CategoriesSwiperPage(
          ids: context
              .read<GalleryAssetsCubit>()
              .state
              .assets
              .reversed
              .map((e) => e.id)
              .toList(),
          title: widget.category.title,
        );
      case AssetCategory.albums:
        final albums = context.watch<GalleryAssetsCubit>().state.groupedAssets;

        return Scaffold(
          appBar: CustomAppbar(title: widget.category.title),
          body: GridView.builder(
            controller: controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums.entries.elementAt(index);
              final asset = album.value.first;
              final second = album.value.elementAtOrNull(1);

              final (title, subtitle) = asset.titleAndSubtitle(widget.category);

              return PhotosCard(
                title: album.key.name,
                asset: asset,
                secondary: second,
                length: album.value.length,
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(
                    AlbumSwiperRoute(path: album.key, title: title),
                  );
                },
              ).p(all: 12);
            },
          ),
        );
    }
  }
}

extension AssetCategoryX on AssetCategory {
  String get title {
    switch (this) {
      case AssetCategory.month:
        return "> months";
      case AssetCategory.nearby:
        return "> nearby";
      case AssetCategory.shuffle:
        return "> shuffled";
      case AssetCategory.videos:
        return "> videos";
      case AssetCategory.reversed:
        return "> old photos first";
      case AssetCategory.albums:
        return "> albums";
    }
  }

  IconData get icon {
    switch (this) {
      case AssetCategory.month:
        return Pixel.calendar;
      case AssetCategory.nearby:
        return Pixel.map;
      case AssetCategory.shuffle:
        return Pixel.shuffle;
      case AssetCategory.videos:
        return Pixel.video;
      case AssetCategory.reversed:
        return Pixel.calendararrowleft;
      case AssetCategory.albums:
        return Pixel.folder;
    }
  }
}

extension AssetEntityX on AssetEntity {
  (String, String) titleAndSubtitle(AssetCategory category) {
    switch (category) {
      case AssetCategory.month:
        final month = createDateTime.format('MMMM');
        final year = createDateTime.format('yyyy');
        return (month, year);
      case AssetCategory.nearby:
        final location = latitude != 0 && longitude != 0
            ? "${latitude?.toStringAsFixed(3)}, ${longitude?.toStringAsFixed(3)}"
            : "No Location";
        return ("Nearby", location);
      case AssetCategory.shuffle:
        final shuffled = createDateTime.format('dd MMMM yyyy');
        return ("Shuffle", shuffled);
      case AssetCategory.videos:
        return ("Videos", "");
      case AssetCategory.reversed:
        return ("Old First", "");
      case AssetCategory.albums:
        return ("Albums", "");
    }
  }
}
