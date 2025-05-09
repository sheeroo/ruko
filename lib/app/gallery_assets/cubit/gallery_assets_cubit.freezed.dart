// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_assets_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GalleryAssetsState {
  List<AssetEntity> get assets => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GalleryAssetsStateCopyWith<GalleryAssetsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryAssetsStateCopyWith<$Res> {
  factory $GalleryAssetsStateCopyWith(
    GalleryAssetsState value,
    $Res Function(GalleryAssetsState) then,
  ) = _$GalleryAssetsStateCopyWithImpl<$Res, GalleryAssetsState>;
  @useResult
  $Res call({List<AssetEntity> assets, TaskStatus status});
}

/// @nodoc
class _$GalleryAssetsStateCopyWithImpl<$Res, $Val extends GalleryAssetsState>
    implements $GalleryAssetsStateCopyWith<$Res> {
  _$GalleryAssetsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? assets = null, Object? status = null}) {
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
                        as TaskStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GalleryAssetsStateImplCopyWith<$Res>
    implements $GalleryAssetsStateCopyWith<$Res> {
  factory _$$GalleryAssetsStateImplCopyWith(
    _$GalleryAssetsStateImpl value,
    $Res Function(_$GalleryAssetsStateImpl) then,
  ) = __$$GalleryAssetsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AssetEntity> assets, TaskStatus status});
}

/// @nodoc
class __$$GalleryAssetsStateImplCopyWithImpl<$Res>
    extends _$GalleryAssetsStateCopyWithImpl<$Res, _$GalleryAssetsStateImpl>
    implements _$$GalleryAssetsStateImplCopyWith<$Res> {
  __$$GalleryAssetsStateImplCopyWithImpl(
    _$GalleryAssetsStateImpl _value,
    $Res Function(_$GalleryAssetsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? assets = null, Object? status = null}) {
    return _then(
      _$GalleryAssetsStateImpl(
        assets:
            null == assets
                ? _value._assets
                : assets // ignore: cast_nullable_to_non_nullable
                    as List<AssetEntity>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as TaskStatus,
      ),
    );
  }
}

/// @nodoc

class _$GalleryAssetsStateImpl implements _GalleryAssetsState {
  const _$GalleryAssetsStateImpl({
    final List<AssetEntity> assets = const [],
    this.status = TaskStatus.initial,
  }) : _assets = assets;

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
  final TaskStatus status;

  @override
  String toString() {
    return 'GalleryAssetsState(assets: $assets, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryAssetsStateImpl &&
            const DeepCollectionEquality().equals(other._assets, _assets) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_assets),
    status,
  );

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GalleryAssetsStateImplCopyWith<_$GalleryAssetsStateImpl> get copyWith =>
      __$$GalleryAssetsStateImplCopyWithImpl<_$GalleryAssetsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _GalleryAssetsState implements GalleryAssetsState {
  const factory _GalleryAssetsState({
    final List<AssetEntity> assets,
    final TaskStatus status,
  }) = _$GalleryAssetsStateImpl;

  @override
  List<AssetEntity> get assets;
  @override
  TaskStatus get status;

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GalleryAssetsStateImplCopyWith<_$GalleryAssetsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
