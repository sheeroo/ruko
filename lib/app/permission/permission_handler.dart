import 'package:mutex/mutex.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionType { notification, mic, gallery }

class PermissionHandler {
  PermissionHandler._(this.permission, this.type);

  factory PermissionHandler.of(PermissionType type) {
    switch (type) {
      case PermissionType.notification:
        return notification;
      case PermissionType.mic:
        return mic;
      case PermissionType.gallery:
        return gallery;
    }
  }

  static final notification = PermissionHandler._(
    Permission.notification,
    PermissionType.notification,
  );
  static final mic = PermissionHandler._(
    Permission.microphone,
    PermissionType.mic,
  );
  static final PermissionHandler gallery = PermissionHandler._(
    Permission.photos,
    PermissionType.gallery,
  );

  final mutex = Mutex();
  final Permission permission;
  final PermissionType type;

  Future<bool> get isGranted async {
    final status = await permission.status;
    return status.isGranted;
  }

  Future<bool> get isPermantentlyDenied async {
    final status = await permission.status;
    return status.isPermanentlyDenied || status.isLimited;
  }

  Future<bool?> request() async {
    return mutex.protect(() async {
      if (await isPermantentlyDenied) {
        await openAppSettings();
        return null;
      }

      final status = await permission.request();
      return status.isGranted;
    });
  }
}
