import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/filter_options.dart';
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

    emit(
      state.copyWith(
        paths: paths,
        status: TaskStatus.success,
      ),
    );
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(status: TaskStatus.error));
    super.addError(error, stackTrace);
  }
}
