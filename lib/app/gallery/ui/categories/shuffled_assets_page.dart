import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/gallery/cubit/albums_cubit.dart';
import 'package:ruko/app/gallery/cubit/assets_paginator_cubit.dart';
import 'package:ruko/app/gallery/ui/widgets/swiper/swiper.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class ShuffledAssetsPage extends StatelessWidget {
  const ShuffledAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppbar(title: "Shuffled"),
      body: BlocBuilder<AlbumsCubit, AlbumsState>(
        buildWhen: (prev, next) => prev.defaultAlbum != next.defaultAlbum,
        builder: (context, state) {
          final album = state.defaultAlbum;
          if (album == null) {
            return const SizedBox.shrink();
          }
          return BlocProvider(
            create: (context) => AssetsPaginatorCubit(
              album.path,
              shuffle: true,
              pageSize: album.assetCount.clamp(0, 25000),
            )..loadNextPage(),
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
