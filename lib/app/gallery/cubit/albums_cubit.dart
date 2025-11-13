import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/utils/filter_options.dart';
import 'package:ruko/app/gallery/utils/get_deletable_assets.dart';
import 'package:ruko/core/enums/status.dart';

part 'albums_cubit.freezed.dart';
part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit() : super(const AlbumsState());

  Future<void> loadAlbums() async {
    emit(state.copyWith(status: TaskStatus.running));

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.all,
      filterOption: FilterOptions.createdAtDesc,
    );

    List<Album> albums = [];
    for (final path in paths) {
      final assets = await path.getAllDeletableAssets(page: 0, size: 5);
      if (assets.isEmpty) continue;
      final assetCount = await path.assetCountAsync;
      final album = Album(
        path: path,
        previewAssets: assets,
        assetCount: assetCount,
      );
      albums.add(album);
    }

    emit(
      state.copyWith(albums: albums, status: TaskStatus.success),
    );
  }
}
