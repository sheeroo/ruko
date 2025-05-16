import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/calendar/calendar_appbar.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/swiper/custom_controller.dart';
import 'package:image_delete_demo/app/swiper/swiper.dart';

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
    final assets =
        context.watch<GalleryAssetsCubit>().state.assets.where((asset) {
          return widget.ids.contains(asset.id);
        }).toList();
    return Scaffold(
      appBar: CalendarAppbar(title: widget.title),
      body: AssetSwiper(controller: controller, assets: assets),
    );
  }
}
