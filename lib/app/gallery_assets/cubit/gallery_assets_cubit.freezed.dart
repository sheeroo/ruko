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
  List<(AssetEntity, AssetPathEntity)> get keyedAssets =>
      throw _privateConstructorUsedError;
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
  $Res call({
    List<(AssetEntity, AssetPathEntity)> keyedAssets,
    TaskStatus status,
  });
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
  $Res call({Object? keyedAssets = null, Object? status = null}) {
    return _then(
      _value.copyWith(
            keyedAssets:
                null == keyedAssets
                    ? _value.keyedAssets
                    : keyedAssets // ignore: cast_nullable_to_non_nullable
                        as List<(AssetEntity, AssetPathEntity)>,
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
  $Res call({
    List<(AssetEntity, AssetPathEntity)> keyedAssets,
    TaskStatus status,
  });
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
  $Res call({Object? keyedAssets = null, Object? status = null}) {
    return _then(
      _$GalleryAssetsStateImpl(
        keyedAssets:
            null == keyedAssets
                ? _value._keyedAssets
                : keyedAssets // ignore: cast_nullable_to_non_nullable
                    as List<(AssetEntity, AssetPathEntity)>,
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

class _$GalleryAssetsStateImpl extends _GalleryAssetsState {
  const _$GalleryAssetsStateImpl({
    final List<(AssetEntity, AssetPathEntity)> keyedAssets = const [],
    this.status = TaskStatus.initial,
  }) : _keyedAssets = keyedAssets,
       super._();

  final List<(AssetEntity, AssetPathEntity)> _keyedAssets;
  @override
  @JsonKey()
  List<(AssetEntity, AssetPathEntity)> get keyedAssets {
    if (_keyedAssets is EqualUnmodifiableListView) return _keyedAssets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyedAssets);
  }

  @override
  @JsonKey()
  final TaskStatus status;

  @override
  String toString() {
    return 'GalleryAssetsState(keyedAssets: $keyedAssets, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryAssetsStateImpl &&
            const DeepCollectionEquality().equals(
              other._keyedAssets,
              _keyedAssets,
            ) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_keyedAssets),
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

abstract class _GalleryAssetsState extends GalleryAssetsState {
  const factory _GalleryAssetsState({
    final List<(AssetEntity, AssetPathEntity)> keyedAssets,
    final TaskStatus status,
  }) = _$GalleryAssetsStateImpl;
  const _GalleryAssetsState._() : super._();

  @override
  List<(AssetEntity, AssetPathEntity)> get keyedAssets;
  @override
  TaskStatus get status;

  /// Create a copy of GalleryAssetsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GalleryAssetsStateImplCopyWith<_$GalleryAssetsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
