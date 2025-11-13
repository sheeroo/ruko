import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'delete_state.dart';

class ImageDeleteCubit extends Cubit<ImageDeleteState> {
  ImageDeleteCubit() : super(ImageDeleteState(entities: {}));

  void add(AssetEntity entity) {
    final entities = {...state.entities};
    entities.add(entity);
    emit(state.copyWith(entities: entities));
  }

  void remove(AssetEntity entity) {
    final entities = {...state.entities};
    entities.remove(entity);
    emit(state.copyWith(entities: entities));
  }

  void reset() {
    emit(state.copyWith(entities: {}));
  }
}
