import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo._();
  static final instance = AppInfo._();
  PackageInfo? _appInfo;
  PackageInfo get packageInfo {
    if (_appInfo == null) {
      throw Exception('AppInfo not loaded');
    }
    return _appInfo!;
  }

  String get version => '${packageInfo.version}+${packageInfo.buildNumber}';

  Future<void> loadAppInfo() async {
    final appInfo = await PackageInfo.fromPlatform();
    _appInfo = appInfo;
  }
}
