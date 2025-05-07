import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

// ignore: constant_identifier_names
const int _CACHE_SIZE = 3;

class AssetLoaderRepository {
  final Map<AssetEntity, File> _cache = {};
  Map<AssetEntity, File> get cache => _cache;

  Future<File?> getFile(AssetEntity asset) async {
    if (_cache.containsKey(asset)) {
      return _cache[asset];
    }
    return asset.file;
  }

  void addAndLoadAsset(AssetEntity asset) async {
    if (_cache.length >= _CACHE_SIZE) {
      _cache.remove(_cache.keys.first);
    }
    if (_cache.containsKey(asset)) {
      return;
    }
    final file = await asset.file;
    if (file != null) {
      _cache[asset] = file;
    }
  }
}

class AssetCacheArtifact {
  AssetCacheArtifact({required this.asset, required this.file});
  final AssetEntity asset;
  final File? file;
}
