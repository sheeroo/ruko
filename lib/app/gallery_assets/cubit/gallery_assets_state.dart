part of 'gallery_assets_cubit.dart';

@freezed
class GalleryAssetsState with _$GalleryAssetsState {
  const factory GalleryAssetsState({
    @Default([]) List<AssetEntity> assets,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _GalleryAssetsState;
}
