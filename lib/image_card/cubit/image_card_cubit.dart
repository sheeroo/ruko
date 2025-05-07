import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/asset_loader_repository.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_card_state.dart';

class ImageCardCubit extends Cubit<ImageCardState> {
  ImageCardCubit(this.assetEntity, {required this.repository})
    : super(ImageCardInitial());

  final AssetEntity assetEntity;
  final AssetLoaderRepository repository;

  void loadFile() async {
    try {
      emit(ImageCardLoading());
      final file = await assetEntity.file;
      emit(ImageCardLoaded(file!));
    } catch (e) {
      emit(ImageCardError());
    }
  }
}
