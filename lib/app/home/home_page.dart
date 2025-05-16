import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/home/home_appbar.dart';
import 'package:image_delete_demo/app/swiper/custom_controller.dart';
import 'package:image_delete_demo/app/swiper/swiper.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = CustomSwiperController();
  int deletedAssetsCount = 0;
  @override
  Widget build(BuildContext context) {
    final assets = context.watch<GalleryAssetsCubit>().state.assets;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: HomeAppbar(
        onDelete: (ids) {
          controller.setCardIndex(controller.cardIndex! - ids.length);
          controller.addDeleted(ids.length);
        },
      ),
      body: AssetSwiper(controller: controller, assets: assets),
    );
  }
}
