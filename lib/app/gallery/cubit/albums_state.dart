part of 'albums_cubit.dart';

@freezed
class AlbumsState with _$AlbumsState {
  const factory AlbumsState({
    @Default([]) List<Album> albums,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _AlbumsState;
  const AlbumsState._();

  Album? get defaultAlbum {
    return albums.firstWhereOrNull((album) => album.isDefaultAlbum);
  }
}

class Album {
  Album({
    required this.path,
    required this.previewAssets,
    required this.assetCount,
  });

  final AssetPathEntity path;
  final List<AssetEntity> previewAssets;
  final int assetCount;

  String get id => path.id;
  String get name => path.name;
  bool get isDefaultAlbum => path.isAll;
}
