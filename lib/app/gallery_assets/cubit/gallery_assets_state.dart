part of 'gallery_assets_cubit.dart';

@freezed
class GalleryAssetsState with _$GalleryAssetsState {
  const factory GalleryAssetsState({
    @Default([]) List<AssetEntity> assets,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _GalleryAssetsState;

  const GalleryAssetsState._();
}

extension AssetCategoryX on List<AssetEntity> {
  Map<String, List<AssetEntity>> fromCategory(AssetCategory category) {
    switch (category) {
      case AssetCategory.month:
        final grouped = groupBy(this, (AssetEntity e) {
          final month = e.createDateTime.format('MMMM');
          final year = e.createDateTime.format('yyyy');
          return "$month, $year".toLowerCase();
        });
        return grouped;
      case AssetCategory.screenshots:
        final assetsWithLocation = where(
          (e) => e.latitude == 0 && e.longitude == 0,
        );
        final grouped = groupBy(assetsWithLocation, (AssetEntity e) {
          final seconds = e.createDateTime.millisecondsSinceEpoch / 1000;
          final groupAt = seconds - (seconds % 86400 * 7);
          return groupAt.toString();
        });
        grouped.removeWhere((key, value) => value.length <= 1);
        final sorted = Map.fromEntries(
          grouped.entries.toList()
            ..sort((a, b) => b.value.length.compareTo(a.value.length)),
        );
        return sorted;
      case AssetCategory.nearby:
        final geoHasher = GeoHasher();
        final assetsWithLocation = where(
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
      case AssetCategory.shuffle:
        final shuffled = [...toList()]..shuffle();
        return {'shuffled': shuffled};
    }
  }
}
