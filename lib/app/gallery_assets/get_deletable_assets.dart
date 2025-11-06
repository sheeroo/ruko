import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

const platform = MethodChannel('photo_utils');

Future<List<String>> getDeletableIds(List<String> ids) async {
  final List<dynamic> result = await platform.invokeMethod('isDeletable', {
    'ids': ids,
  });
  return result.cast<String>();
}

extension AssetPathEntityX on AssetPathEntity {
  Future<List<AssetEntity>> getAllDeletableAssets() async {
    final assetCount = await assetCountAsync;
    if (assetCount == 0) return [];
    final assets = await getAssetListPaged(page: 0, size: assetCount);
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
