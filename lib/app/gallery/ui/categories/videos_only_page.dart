import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/gallery/cubit/asset_paths_cubit.dart';
import 'package:ruko/app/gallery/cubit/assets_paginator_cubit.dart';
import 'package:ruko/app/gallery/ui/widgets/swiper/swiper.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class VideosOnlyPage extends StatelessWidget {
  const VideosOnlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppbar(title: "Videos Only"),
      body: BlocBuilder<AssetPathsCubit, AssetPathsState>(
        buildWhen: (prev, next) => prev.videosOnlyPath != next.videosOnlyPath,
        builder: (context, state) {
          final path = state.videosOnlyPath;
          if (path == null) {
            return const SizedBox.shrink();
          }
          return BlocProvider(
            create: (context) => AssetsPaginatorCubit(path)..loadNextPage(),
            child: BlocBuilder<AssetsPaginatorCubit, AssetsPaginatorState>(
              buildWhen: (prev, next) =>
                  prev.assets.length != next.assets.length,
              builder: (context, state) {
                return AssetSwiper(assets: state.assets);
              },
            ),
          );
        },
      ),
    );
  }
}
