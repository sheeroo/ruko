import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/categories/categories_page.dart';
import 'package:ruko/app/categories/categories_swiper_page.dart';
import 'package:ruko/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

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
    final entries =
        context
            .watch<GalleryAssetsCubit>()
            .state
            .assets
            .fromCategory(widget.category)
            .entries;
    switch (widget.category) {
      case AssetCategory.month:
      case AssetCategory.nearby:
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
                assets: entry.value,
              ).p(all: 12);
            },
          ),
        );
      case AssetCategory.screenshots:
        final screenshots =
            entries.map((e) => e.value).expand((e) => e).toList()
              ..sort((a, b) => a.createDateTime.compareTo(b.createDateTime));
        return CategoriesSwiperPage(
          ids: screenshots.map((e) => e.id).toList(),
          title: widget.category.title,
        );
      case AssetCategory.shuffle:
        return CategoriesSwiperPage(
          ids: shuffled.map((e) => e.id).toList(),
          title: widget.category.title,
        );
    }
  }
}

extension AssetCategoryX on AssetCategory {
  String get title {
    switch (this) {
      case AssetCategory.month:
        return "> months";
      case AssetCategory.screenshots:
        return "> screenshots & other";
      case AssetCategory.nearby:
        return "> nearby";
      case AssetCategory.shuffle:
        return "> shuffled";
    }
  }

  IconData get icon {
    switch (this) {
      case AssetCategory.month:
        return Pixel.calendar;
      case AssetCategory.screenshots:
        return Pixel.notedelete;
      case AssetCategory.nearby:
        return Pixel.map;
      case AssetCategory.shuffle:
        return Pixel.shuffle;
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
      case AssetCategory.screenshots:
        final week = createDateTime.format('EEEE');
        final date = createDateTime.format('dd MMMM yyyy');
        return (week, date);
      case AssetCategory.nearby:
        final location =
            latitude != 0 && longitude != 0
                ? "${latitude?.toStringAsFixed(3)}, ${longitude?.toStringAsFixed(3)}"
                : "No Location";
        return ("Nearby", location);
      case AssetCategory.shuffle:
        final shuffled = createDateTime.format('dd MMMM yyyy');
        return ("Shuffle", shuffled);
    }
  }
}
