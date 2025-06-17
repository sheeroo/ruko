part of 'image_delete_cubit.dart';

@immutable
class ImageDeleteState {
  final Set<AssetEntity> entities;
  const ImageDeleteState({required this.entities});

  ImageDeleteState copyWith({Set<AssetEntity>? entities}) {
    return ImageDeleteState(entities: entities ?? this.entities);
  }
}
