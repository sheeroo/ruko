import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/categories/categories_page.dart';
import 'package:ruko/app/gallery_assets/get_deletable_assets.dart';
import 'package:ruko/core/enums/status.dart';
import 'package:ruko/core/extensions/core_extensions.dart';

part 'gallery_assets_cubit.freezed.dart';
part 'gallery_assets_state.dart';

class GalleryAssetsCubit extends Cubit<GalleryAssetsState> {
  GalleryAssetsCubit() : super(GalleryAssetsState());

  Future<void> loadAssets() async {
    emit(state.copyWith(status: TaskStatus.running));
    final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
      orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
    );

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.all,
      filterOption: filterOptionGroup,
    );

    List<(AssetEntity, AssetPathEntity)> allAssets = [];
    for (final path in paths) {
      final assets = await path.getAllDeletableAssets();
      if (assets.isEmpty) continue;
      allAssets.addAll(assets.map((e) => (e, path)));
    }

    emit(
      state.copyWith(
        keyedAssets: allAssets,
        status: TaskStatus.success,
      ),
    );
  }

  void removeAssets(List<String> ids) {
    final assets = state.keyedAssets
        .where((e) => !ids.contains(e.$1.id))
        .toList();
    emit(state.copyWith(keyedAssets: assets));
  }

  void toggleFavoriteAsset(AssetEntity entity) {
    final modifiedAssets = state.keyedAssets.copyMatchWith(
      predicate: (e) {
        return e.$1.id == entity.id;
      },
      newItem: (e) {
        if (Platform.isIOS) {
          PhotoManager.editor.darwin.favoriteAsset(
            entity: entity,
            favorite: !e.$1.isFavorite,
          );
        }
        return (e.$1.copyWith(isFavorite: !e.$1.isFavorite), e.$2);
      },
    );

    emit(
      state.copyWith(
        keyedAssets: modifiedAssets,
      ),
    );
  }
}
