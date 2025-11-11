import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/gallery/cubit/asset_paths_cubit.dart';
import 'package:ruko/app/gallery/cubit/assets_paginator_cubit.dart';
import 'package:ruko/app/home/home_appbar.dart';
import 'package:ruko/app/swiper/custom_controller.dart';
import 'package:ruko/app/swiper/swiper.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: HomeAppbar(),
      body: BlocBuilder<AssetPathsCubit, AssetPathsState>(
        buildWhen: (prev, next) => prev.defaultPath != next.defaultPath,
        builder: (context, state) {
          final defaultPath = state.defaultPath;
          if (defaultPath == null) {
            return const Center(
              child: Text(
                'No albums found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return BlocProvider(
            create: (context) =>
                AssetsPaginatorCubit(defaultPath)..loadNextPage(),
            child: BlocBuilder<AssetsPaginatorCubit, AssetsPaginatorState>(
              buildWhen: (prev, next) =>
                  prev.assets.length != next.assets.length,
              builder: (context, state) {
                return AssetSwiper(
                  controller: controller,
                  assets: state.assets,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
