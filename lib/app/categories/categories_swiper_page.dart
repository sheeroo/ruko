import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/swiper/custom_controller.dart';
import 'package:image_delete_demo/app/swiper/swiper.dart';
import 'package:image_delete_demo/core/widgets/custom_appbar.dart';
import 'package:photo_manager/photo_manager.dart';

@RoutePage()
class CategoriesSwiperPage extends StatefulWidget {
  const CategoriesSwiperPage({
    super.key,
    required this.ids,
    required this.title,
  });

  final String title;
  final List<String> ids;

  @override
  State<CategoriesSwiperPage> createState() => _CategoriesSwipertate();
}

class _CategoriesSwipertate extends State<CategoriesSwiperPage> {
  final controller = CustomSwiperController();

  @override
  Widget build(BuildContext context) {
    final allAssets = context.watch<GalleryAssetsCubit>().state.assets;
    final assets =
        widget.ids
            .map((id) {
              try {
                return allAssets.firstWhere((asset) => asset.id == id);
              } catch (e) {
                return null;
              }
            })
            .whereType<AssetEntity>()
            .toList();
    return Scaffold(
      appBar: CustomAppbar(title: widget.title),
      body: AssetSwiper(controller: controller, assets: assets),
    );
  }
}
