import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/utils/filter_options.dart';
import 'package:ruko/core/enums/status.dart';

part 'asset_paths_cubit.freezed.dart';
part 'asset_paths_state.dart';

class AssetPathsCubit extends Cubit<AssetPathsState> {
  AssetPathsCubit({
    FilterOptionGroup? filterOptionGroup,
    this.onlyAll = false,
  }) : _filterOptionGroup = filterOptionGroup ?? FilterOptions.createdAtDesc,
       super(const AssetPathsState());

  final bool onlyAll;
  final FilterOptionGroup _filterOptionGroup;

  Future<void> loadPaths() async {
    emit(state.copyWith(status: TaskStatus.running));

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: onlyAll,
      filterOption: _filterOptionGroup,
      type: RequestType.all,
    );

    final defaultReversedPath = await PhotoManager.getAssetPathList(
      onlyAll: true,
      filterOption: FilterOptions.createdAtAsc,
      type: RequestType.all,
    );

    final videosOnlyPath = await PhotoManager.getAssetPathList(
      onlyAll: true,
      filterOption: _filterOptionGroup,
      type: RequestType.video,
    );

    emit(
      state.copyWith(
        paths: paths.where((path) => !path.isAll).toList(),
        defaultPath: paths.firstWhereOrNull((e) => e.isAll),
        defaultReversedPath: defaultReversedPath.first,
        videosOnlyPath: videosOnlyPath.first,
        status: TaskStatus.success,
      ),
    );
  }
}
