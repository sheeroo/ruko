import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_delete_demo/core/enums/status.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:photo_manager/photo_manager.dart';

part 'gallery_assets_cubit.freezed.dart';
part 'gallery_assets_state.dart';

class GalleryAssetsCubit extends Cubit<GalleryAssetsState> {
  GalleryAssetsCubit() : super(GalleryAssetsState());

  Future<void> loadAssets() async {
    emit(state.copyWith(status: TaskStatus.running));
    final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
      imageOption: const FilterOption(
        sizeConstraint: SizeConstraint(minWidth: 0, minHeight: 0),
      ),
      orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
    );

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: true, // Usually gets the main "Recents" or "All Photos" album
      type: RequestType.image,
      filterOption: filterOptionGroup,
    );

    if (paths.isNotEmpty) {
      const int loadCount = 20000;
      final assets = await paths[0].getAssetListPaged(page: 0, size: loadCount);
      emit(state.copyWith(assets: assets, status: TaskStatus.success));
    }
  }

  void removeAssets(List<String> ids) {
    final assets = state.assets.where((e) => !ids.contains(e.id)).toList();
    emit(state.copyWith(assets: assets));
  }
}
