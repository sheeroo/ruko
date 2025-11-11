// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assets_paginator_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AssetsPaginatorState {
  List<AssetEntity> get assets => throw _privateConstructorUsedError;
  PaginatorStatus get status => throw _privateConstructorUsedError;
  int? get currentPage => throw _privateConstructorUsedError;

  /// Create a copy of AssetsPaginatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetsPaginatorStateCopyWith<AssetsPaginatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetsPaginatorStateCopyWith<$Res> {
  factory $AssetsPaginatorStateCopyWith(
    AssetsPaginatorState value,
    $Res Function(AssetsPaginatorState) then,
  ) = _$AssetsPaginatorStateCopyWithImpl<$Res, AssetsPaginatorState>;
  @useResult
  $Res call({
    List<AssetEntity> assets,
    PaginatorStatus status,
    int? currentPage,
  });
}

/// @nodoc
class _$AssetsPaginatorStateCopyWithImpl<
  $Res,
  $Val extends AssetsPaginatorState
>
    implements $AssetsPaginatorStateCopyWith<$Res> {
  _$AssetsPaginatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetsPaginatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assets = null,
    Object? status = null,
    Object? currentPage = freezed,
  }) {
    return _then(
      _value.copyWith(
            assets:
                null == assets
                    ? _value.assets
                    : assets // ignore: cast_nullable_to_non_nullable
                        as List<AssetEntity>,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as PaginatorStatus,
            currentPage:
                freezed == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssetsPaginatorStateImplCopyWith<$Res>
    implements $AssetsPaginatorStateCopyWith<$Res> {
  factory _$$AssetsPaginatorStateImplCopyWith(
    _$AssetsPaginatorStateImpl value,
    $Res Function(_$AssetsPaginatorStateImpl) then,
  ) = __$$AssetsPaginatorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AssetEntity> assets,
    PaginatorStatus status,
    int? currentPage,
  });
}

/// @nodoc
class __$$AssetsPaginatorStateImplCopyWithImpl<$Res>
    extends _$AssetsPaginatorStateCopyWithImpl<$Res, _$AssetsPaginatorStateImpl>
    implements _$$AssetsPaginatorStateImplCopyWith<$Res> {
  __$$AssetsPaginatorStateImplCopyWithImpl(
    _$AssetsPaginatorStateImpl _value,
    $Res Function(_$AssetsPaginatorStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetsPaginatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assets = null,
    Object? status = null,
    Object? currentPage = freezed,
  }) {
    return _then(
      _$AssetsPaginatorStateImpl(
        assets:
            null == assets
                ? _value._assets
                : assets // ignore: cast_nullable_to_non_nullable
                    as List<AssetEntity>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as PaginatorStatus,
        currentPage:
            freezed == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$AssetsPaginatorStateImpl extends _AssetsPaginatorState {
  const _$AssetsPaginatorStateImpl({
    final List<AssetEntity> assets = const [],
    this.status = PaginatorStatus.initial,
    this.currentPage,
  }) : _assets = assets,
       super._();

  final List<AssetEntity> _assets;
  @override
  @JsonKey()
  List<AssetEntity> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  @override
  @JsonKey()
  final PaginatorStatus status;
  @override
  final int? currentPage;

  @override
  String toString() {
    return 'AssetsPaginatorState(assets: $assets, status: $status, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetsPaginatorStateImpl &&
            const DeepCollectionEquality().equals(other._assets, _assets) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_assets),
    status,
    currentPage,
  );

  /// Create a copy of AssetsPaginatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetsPaginatorStateImplCopyWith<_$AssetsPaginatorStateImpl>
  get copyWith =>
      __$$AssetsPaginatorStateImplCopyWithImpl<_$AssetsPaginatorStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AssetsPaginatorState extends AssetsPaginatorState {
  const factory _AssetsPaginatorState({
    final List<AssetEntity> assets,
    final PaginatorStatus status,
    final int? currentPage,
  }) = _$AssetsPaginatorStateImpl;
  const _AssetsPaginatorState._() : super._();

  @override
  List<AssetEntity> get assets;
  @override
  PaginatorStatus get status;
  @override
  int? get currentPage;

  /// Create a copy of AssetsPaginatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetsPaginatorStateImplCopyWith<_$AssetsPaginatorStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
