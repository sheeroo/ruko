import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ruko/core/error_logger/error_log.dart';
import 'package:ruko/core/error_logger/error_logger.dart';

const platform = MethodChannel('photo_utils');

Future<List<String>> getDeletableIds(List<String> ids) async {
  try {
    final List<dynamic> result = await platform.invokeMethod('isDeletable', {
      'ids': ids,
    });
    return result.cast<String>();
  } on PlatformException catch (e, st) {
    ErrorLogger.instance.capture(
      message: 'Native photo_utils channel error: ${e.message ?? e.code}',
      source: ErrorSource.platform,
      severity: ErrorSeverity.error,
      error: e,
      stackTrace: st,
      context: 'getDeletableIds',
      metadata: {'code': e.code, 'assetCount': ids.length},
    );
    // Fall back to treating all assets as deletable so the app stays usable.
    return ids;
  }
}

extension AssetPathEntityX on AssetPathEntity {
  Future<List<AssetEntity>> getAllDeletableAssets({
    int? page,
    int? size,
  }) async {
    final assetCount = await assetCountAsync;
    if (assetCount == 0) return [];
    final assets = await getAssetListPaged(
      page: page ?? 0,
      size: size ?? assetCount,
    );
    if (isAll) {
      return assets;
    }
    final deletableAssets =
        await getDeletableIds(
          assets.map((e) => e.id).toList(),
        ).then((deletableIds) {
          final deletableSet = deletableIds.toSet();
          return assets.map((e) {
            if (deletableSet.contains(e.id)) {
              return e;
            }
            return null;
          });
        });
    return deletableAssets.nonNulls.toList();
  }
}
