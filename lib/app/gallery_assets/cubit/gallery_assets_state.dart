part of 'gallery_assets_cubit.dart';

@freezed
class GalleryAssetsState with _$GalleryAssetsState {
  const factory GalleryAssetsState({
    @Default([]) List<AssetEntity> assets,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _GalleryAssetsState;

  const GalleryAssetsState._();

  Map<String, List<AssetEntity>> get groupedByMonth {
    final grouped = groupBy(assets, (AssetEntity e) {
      final season = e.createDateTime.getSeason;
      final month = e.createDateTime.format('MMMM');
      final year = e.createDateTime.format('yyyy');
      return "$month, $season $year".toLowerCase();
    });
    return grouped;
  }
}
