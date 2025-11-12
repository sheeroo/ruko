import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/cubit/assets_paginator_cubit.dart';
import 'package:ruko/app/gallery/ui/widgets/swiper/swiper.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class GenericSwiperPage extends StatelessWidget {
  const GenericSwiperPage({
    super.key,
    required this.path,
    this.initialAssets = const [],
    this.title,
  });

  final String? title;
  final AssetPathEntity path;
  final List<AssetEntity> initialAssets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: BlocProvider(
        create: (context) {
          final cubit = AssetsPaginatorCubit(
            path,
            initialAssets: initialAssets,
          );
          if (initialAssets.isEmpty) {
            cubit.loadNextPage();
          }
          return cubit;
        },
        child: BlocBuilder<AssetsPaginatorCubit, AssetsPaginatorState>(
          buildWhen: (prev, next) => prev.assets.length != next.assets.length,
          builder: (context, state) {
            return AssetSwiper(
              assets: state.assets,
              paginate: initialAssets.isNotEmpty,
            );
          },
        ),
      ),
    );
  }
}
