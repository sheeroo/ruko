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
      final month = e.createDateTime.format('MMMM');
      final year = e.createDateTime.format('yyyy');
      return "$month, $year".toLowerCase();
    });
    return grouped;
  }

  Map<double, List<AssetEntity>> get groupedBySecond {
    final assetsWithLocation = assets.where(
      (e) => e.latitude != 0 && e.longitude != 0,
    );
    final grouped = groupBy(assetsWithLocation, (AssetEntity e) {
      final seconds = e.createDateTime.millisecondsSinceEpoch / 1000;
      final groupAt = seconds - (seconds % 43200);
      return groupAt;
    });
    grouped.removeWhere((key, value) => value.length <= 1);
    final sorted = Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.value.length.compareTo(a.value.length)),
    );

    return sorted;
  }
}
