import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/categories/categories_page.dart';
import 'package:ruko/core/enums/status.dart';
import 'package:ruko/core/extensions/core_extensions.dart';

part 'gallery_assets_cubit.freezed.dart';
part 'gallery_assets_state.dart';

class GalleryAssetsCubit extends Cubit<GalleryAssetsState> {
  GalleryAssetsCubit() : super(GalleryAssetsState());

  Future<void> loadAssets() async {
    emit(state.copyWith(status: TaskStatus.running));
    final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
      // imageOption: const FilterOption(
      //   sizeConstraint: SizeConstraint(minWidth: 0, minHeight: 0),
      // ),
      orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
    );

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.all,
      filterOption: filterOptionGroup,
    );

    List<AssetEntity> allAssets = [];
    for (final path in paths) {
      final assets = await path.getAssetListPaged(page: 0, size: 10000);
      allAssets.addAll(assets);
    }
    emit(
      state.copyWith(
        assets: allAssets,
        status: TaskStatus.success,
      ),
    );
  }

  void removeAssets(List<String> ids) {
    final assets = state.assets.where((e) => !ids.contains(e.id)).toList();
    emit(state.copyWith(assets: assets));
  }

  void toggleFavoriteAsset(AssetEntity entity) {
    emit(
      state.copyWith(
        assets: state.assets.map((e) {
          if (e.id == entity.id) {
            PhotoManager.editor.darwin.favoriteAsset(
              entity: e,
              favorite: !e.isFavorite,
            );
            return e.copyWith(isFavorite: !e.isFavorite);
          }
          return e;
        }).toList(),
      ),
    );
  }
}
