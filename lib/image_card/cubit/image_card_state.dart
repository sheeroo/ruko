part of 'image_card_cubit.dart';

@immutable
sealed class ImageCardState {
  const ImageCardState();
}

final class ImageCardInitial extends ImageCardState {}

final class ImageCardLoading extends ImageCardState {}

final class ImageCardError extends ImageCardState {}

final class ImageCardLoaded extends ImageCardState {
  const ImageCardLoaded(this.file);

  final File file;
}
