import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/gallery/cubit/albums_cubit.dart';
import 'package:ruko/app/gallery/ui/widgets/photos_card.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final albums = context.watch<AlbumsCubit>().state.albums;
    return Scaffold(
      appBar: CustomAppbar(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          final asset = album.previewAssets.first;
          final second = album.previewAssets.elementAtOrNull(1);

          return PhotosCard(
            title: album.name,
            subtitle: "",
            asset: asset,
            secondary: second,
            length: album.assetCount,
            onTap: () async {
              HapticFeedback.selectionClick();
              await context.router.push(
                GenericSwiperRoute(path: album.path),
              );
              if (!context.mounted) return;
              await context.read<AlbumsCubit>().loadAlbums();
            },
          ).p(all: 12);
        },
      ),
    );
  }
}
