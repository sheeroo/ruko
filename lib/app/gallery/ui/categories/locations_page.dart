import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/cubit/albums_cubit.dart';
import 'package:ruko/app/gallery/cubit/assets_paginator_cubit.dart';
import 'package:ruko/app/gallery/ui/widgets/photos_card.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final geoHasher = GeoHasher();
  Map<String, List<AssetEntity>> getGroupedAssets(List<AssetEntity> assets) {
    final assetsWithLocation = assets.where(
      (e) => e.latitude != 0 && e.longitude != 0,
    );
    final grouped = groupBy(assetsWithLocation, (AssetEntity e) {
      final hash = geoHasher.encode(
        e.longitude ?? 0,
        e.latitude ?? 0,
        precision: 6,
      );
      return hash;
    });
    grouped.removeWhere((key, value) => value.length <= 1);
    final sorted = Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.value.length.compareTo(a.value.length)),
    );
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppbar(title: "Places"),
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
              pageSize: album.assetCount.clamp(0, 25000),
            )..loadNextPage(),
            child: BlocBuilder<AssetsPaginatorCubit, AssetsPaginatorState>(
              buildWhen: (prev, next) =>
                  prev.assets.length != next.assets.length,
              builder: (context, state) {
                final locations = getGroupedAssets(state.assets).entries;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final entry = locations.elementAt(index);
                    final asset = entry.value.first;
                    final second = entry.value.elementAtOrNull(1);

                    return PhotosCard(
                      title: "taken at",
                      subtitle: "place ${index + 1}",
                      asset: asset,
                      secondary: second,
                      length: entry.value.length,
                      onTap: () async {
                        HapticFeedback.selectionClick();
                        if (!context.mounted) return;
                        await context.router.push(
                          GenericSwiperRoute(
                            title: "Place ${index + 1}",
                            path: album.path,
                            initialAssets: entry.value,
                          ),
                        );
                        if (!context.mounted) return;
                        await context.read<AlbumsCubit>().loadAlbums();
                      },
                    ).p(all: 12);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
