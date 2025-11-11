part of 'asset_paths_cubit.dart';

@freezed
class AssetPathsState with _$AssetPathsState {
  const factory AssetPathsState({
    @Default([]) List<AssetPathEntity> paths,
    AssetPathEntity? defaultPath,
    AssetPathEntity? defaultReversedPath,
    AssetPathEntity? videosOnlyPath,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _AssetPathsState;

  const AssetPathsState._();

  List<AssetPathEntity> getSecondaryPaths() {
    return paths.where((e) => !e.isAll).toList();
  }
}
