import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:image_delete_demo/core/di/service_locator.dart';

enum InstalledApps { instagram, facebook, whatsapp, telegram }

class InstalledAppsRepository {
  final _appinioSocialShare = AppinioSocialShare();
  List<String>? _installedApps;

  static final instance = sl<InstalledAppsRepository>();

  List<String> get installedApps {
    assert(
      _installedApps != null,
      'Installed apps have not been loaded yet. Call loadInstalledApps() first.',
    );
    return _installedApps!;
  }

  void loadInstalledApps() async {
    final apps = await _appinioSocialShare.getInstalledApps();
    final installedApps =
        apps.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();
    _installedApps = installedApps;
  }
}
