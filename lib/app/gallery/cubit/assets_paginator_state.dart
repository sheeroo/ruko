part of 'assets_paginator_cubit.dart';

@freezed
class AssetsPaginatorState with _$AssetsPaginatorState {
  const factory AssetsPaginatorState({
    @Default([]) List<AssetEntity> assets,
    @Default(PaginatorStatus.initial) PaginatorStatus status,
    int? currentPage,
  }) = _AssetsPaginatorState;
  const AssetsPaginatorState._();

  bool get reachedMax => status == PaginatorStatus.reachedMax;
}
