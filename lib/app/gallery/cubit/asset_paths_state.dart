part of 'asset_paths_cubit.dart';

@freezed
class AssetPathsState with _$AssetPathsState {
  const factory AssetPathsState({
    @Default([]) List<AssetPathEntity> paths,
    @Default(TaskStatus.initial) TaskStatus status,
  }) = _AssetPathsState;

  const AssetPathsState._();

  AssetPathEntity? get defaultPath => paths.firstWhereOrNull((e) => e.isAll);

  List<AssetPathEntity> getSecondaryPaths() {
    return paths.where((e) => !e.isAll).toList();
  }
}
