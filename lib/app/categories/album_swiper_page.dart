import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/cubit/gallery_assets_cubit.dart';
import 'package:ruko/app/swiper/custom_controller.dart';
import 'package:ruko/app/swiper/swiper.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class AlbumSwiperPage extends StatefulWidget {
  const AlbumSwiperPage({
    super.key,
    required this.path,
    required this.title,
  });

  final String title;
  final AssetPathEntity path;

  @override
  State<AlbumSwiperPage> createState() => _CategoriesSwipertate();
}

class _CategoriesSwipertate extends State<AlbumSwiperPage> {
  final controller = CustomSwiperController();

  @override
  Widget build(BuildContext context) {
    final assets =
        context.watch<GalleryAssetsCubit>().state.groupedAssets[widget.path] ??
        [];
    return Scaffold(
      appBar: CustomAppbar(title: widget.title),
      body: AssetSwiper(
        controller: controller,
        assets: assets,
      ),
    );
  }
}
