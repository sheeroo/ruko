import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/home/home_appbar.dart';
import 'package:image_delete_demo/app/swiper/swiper.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final assets = context.watch<GalleryAssetsCubit>().state.assets;
    final controller = AppinioSwiperController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: HomeAppbar(
        onDelete: (ids) {
          controller.setCardIndex(controller.cardIndex! - ids.length);
        },
      ),
      body: AssetSwiper(assets: assets, controller: controller),
    );
  }
}
