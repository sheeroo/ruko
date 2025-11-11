import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/app/gallery/get_deletable_assets.dart';
import 'package:ruko/core/paginator/paginator.dart';

part 'assets_paginator_cubit.freezed.dart';
part 'assets_paginator_state.dart';

class AssetsPaginatorCubit extends Cubit<AssetsPaginatorState> {
  AssetsPaginatorCubit(this.path) : super(const AssetsPaginatorState()) {
    _setupPaginatorListener();
  }

  final AssetPathEntity path;
  int pageSize = 50;
  late final paginator = AssetPaginator(path: path, pageSize: pageSize);

  void _setupPaginatorListener() {
    paginator.statusStream.listen(
      (status) {
        if (isClosed) return;
        emit(state.copyWith(status: status));
      },
    );
  }

  Future<void> loadNextPage() async {
    if (state.reachedMax) return;
    final items = await paginator.fetchNextPage();
    emit(
      state.copyWith(
        assets: [...state.assets, ...items],
        currentPage: paginator.currentPage,
      ),
    );
  }

  void removeAssets(List<String> ids) {
    final assets = state.assets.where((e) => !ids.contains(e.id)).toList();
    emit(state.copyWith(assets: assets));
  }

  void indexChanged(int index) {
    final pageFromIndex = ((index + pageSize / 2) / pageSize).floor() + 1;
    if (pageFromIndex > (state.currentPage ?? 0)) {
      loadNextPage();
    }
  }

  void toggleFavoriteAsset(String id) {
    final assets = state.assets.map((e) {
      if (e.id == id) {
        PhotoManager.editor.darwin.favoriteAsset(
          entity: e,
          favorite: !e.isFavorite,
        );
        return e.copyWith(isFavorite: !e.isFavorite);
      }
      return e;
    }).toList();
    emit(state.copyWith(assets: assets));
  }

  @override
  Future<void> close() {
    paginator.dispose();
    return super.close();
  }
}

class AssetPaginator extends Paginator<AssetEntity> {
  AssetPaginator({required this.path, required super.pageSize});
  final AssetPathEntity path;

  @override
  Future<List<AssetEntity>> fetch(int page) async =>
      path.getAllDeletableAssets(page: page, size: pageSize);
}
