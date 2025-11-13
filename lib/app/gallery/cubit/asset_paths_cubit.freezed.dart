// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_paths_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AssetPathsState {
  List<AssetPathEntity> get paths => throw _privateConstructorUsedError;
  AssetPathEntity? get defaultPath => throw _privateConstructorUsedError;
  AssetPathEntity? get defaultReversedPath =>
      throw _privateConstructorUsedError;
  AssetPathEntity? get videosOnlyPath => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of AssetPathsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetPathsStateCopyWith<AssetPathsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetPathsStateCopyWith<$Res> {
  factory $AssetPathsStateCopyWith(
    AssetPathsState value,
    $Res Function(AssetPathsState) then,
  ) = _$AssetPathsStateCopyWithImpl<$Res, AssetPathsState>;
  @useResult
  $Res call({
    List<AssetPathEntity> paths,
    AssetPathEntity? defaultPath,
    AssetPathEntity? defaultReversedPath,
    AssetPathEntity? videosOnlyPath,
    TaskStatus status,
  });
}

/// @nodoc
class _$AssetPathsStateCopyWithImpl<$Res, $Val extends AssetPathsState>
    implements $AssetPathsStateCopyWith<$Res> {
  _$AssetPathsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetPathsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paths = null,
    Object? defaultPath = freezed,
    Object? defaultReversedPath = freezed,
    Object? videosOnlyPath = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            paths:
                null == paths
                    ? _value.paths
                    : paths // ignore: cast_nullable_to_non_nullable
                        as List<AssetPathEntity>,
            defaultPath:
                freezed == defaultPath
                    ? _value.defaultPath
                    : defaultPath // ignore: cast_nullable_to_non_nullable
                        as AssetPathEntity?,
            defaultReversedPath:
                freezed == defaultReversedPath
                    ? _value.defaultReversedPath
                    : defaultReversedPath // ignore: cast_nullable_to_non_nullable
                        as AssetPathEntity?,
            videosOnlyPath:
                freezed == videosOnlyPath
                    ? _value.videosOnlyPath
                    : videosOnlyPath // ignore: cast_nullable_to_non_nullable
                        as AssetPathEntity?,
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
abstract class _$$AssetPathsStateImplCopyWith<$Res>
    implements $AssetPathsStateCopyWith<$Res> {
  factory _$$AssetPathsStateImplCopyWith(
    _$AssetPathsStateImpl value,
    $Res Function(_$AssetPathsStateImpl) then,
  ) = __$$AssetPathsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AssetPathEntity> paths,
    AssetPathEntity? defaultPath,
    AssetPathEntity? defaultReversedPath,
    AssetPathEntity? videosOnlyPath,
    TaskStatus status,
  });
}

/// @nodoc
class __$$AssetPathsStateImplCopyWithImpl<$Res>
    extends _$AssetPathsStateCopyWithImpl<$Res, _$AssetPathsStateImpl>
    implements _$$AssetPathsStateImplCopyWith<$Res> {
  __$$AssetPathsStateImplCopyWithImpl(
    _$AssetPathsStateImpl _value,
    $Res Function(_$AssetPathsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetPathsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paths = null,
    Object? defaultPath = freezed,
    Object? defaultReversedPath = freezed,
    Object? videosOnlyPath = freezed,
    Object? status = null,
  }) {
    return _then(
      _$AssetPathsStateImpl(
        paths:
            null == paths
                ? _value._paths
                : paths // ignore: cast_nullable_to_non_nullable
                    as List<AssetPathEntity>,
        defaultPath:
            freezed == defaultPath
                ? _value.defaultPath
                : defaultPath // ignore: cast_nullable_to_non_nullable
                    as AssetPathEntity?,
        defaultReversedPath:
            freezed == defaultReversedPath
                ? _value.defaultReversedPath
                : defaultReversedPath // ignore: cast_nullable_to_non_nullable
                    as AssetPathEntity?,
        videosOnlyPath:
            freezed == videosOnlyPath
                ? _value.videosOnlyPath
                : videosOnlyPath // ignore: cast_nullable_to_non_nullable
                    as AssetPathEntity?,
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

class _$AssetPathsStateImpl extends _AssetPathsState {
  const _$AssetPathsStateImpl({
    final List<AssetPathEntity> paths = const [],
    this.defaultPath,
    this.defaultReversedPath,
    this.videosOnlyPath,
    this.status = TaskStatus.initial,
  }) : _paths = paths,
       super._();

  final List<AssetPathEntity> _paths;
  @override
  @JsonKey()
  List<AssetPathEntity> get paths {
    if (_paths is EqualUnmodifiableListView) return _paths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paths);
  }

  @override
  final AssetPathEntity? defaultPath;
  @override
  final AssetPathEntity? defaultReversedPath;
  @override
  final AssetPathEntity? videosOnlyPath;
  @override
  @JsonKey()
  final TaskStatus status;

  @override
  String toString() {
    return 'AssetPathsState(paths: $paths, defaultPath: $defaultPath, defaultReversedPath: $defaultReversedPath, videosOnlyPath: $videosOnlyPath, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetPathsStateImpl &&
            const DeepCollectionEquality().equals(other._paths, _paths) &&
            (identical(other.defaultPath, defaultPath) ||
                other.defaultPath == defaultPath) &&
            (identical(other.defaultReversedPath, defaultReversedPath) ||
                other.defaultReversedPath == defaultReversedPath) &&
            (identical(other.videosOnlyPath, videosOnlyPath) ||
                other.videosOnlyPath == videosOnlyPath) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_paths),
    defaultPath,
    defaultReversedPath,
    videosOnlyPath,
    status,
  );

  /// Create a copy of AssetPathsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetPathsStateImplCopyWith<_$AssetPathsStateImpl> get copyWith =>
      __$$AssetPathsStateImplCopyWithImpl<_$AssetPathsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AssetPathsState extends AssetPathsState {
  const factory _AssetPathsState({
    final List<AssetPathEntity> paths,
    final AssetPathEntity? defaultPath,
    final AssetPathEntity? defaultReversedPath,
    final AssetPathEntity? videosOnlyPath,
    final TaskStatus status,
  }) = _$AssetPathsStateImpl;
  const _AssetPathsState._() : super._();

  @override
  List<AssetPathEntity> get paths;
  @override
  AssetPathEntity? get defaultPath;
  @override
  AssetPathEntity? get defaultReversedPath;
  @override
  AssetPathEntity? get videosOnlyPath;
  @override
  TaskStatus get status;

  /// Create a copy of AssetPathsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetPathsStateImplCopyWith<_$AssetPathsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
