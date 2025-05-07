import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 365),
      maxNrOfCacheObjects: 1000,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );

  static Future<File> getImage(String url) async {
    final fileInfo = await instance.getFileFromCache(url);
    if (fileInfo == null) {
      // File not in cache, download it
      final file = await instance.getSingleFile(url);
      return file;
    } else {
      // File in cache, use it
      return fileInfo.file;
    }
  }

  static Future<void> clearCache() async {
    await instance.emptyCache();
  }
}
