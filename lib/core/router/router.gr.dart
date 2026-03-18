// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i28;

import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/cupertino.dart' as _i26;
import 'package:flutter/material.dart' as _i24;
import 'package:photo_manager/photo_manager.dart' as _i27;
import 'package:ruko/app/gallery/ui/categories/albums_page.dart' as _i2;
import 'package:ruko/app/gallery/ui/categories/categories_bottom_sheet.dart'
    as _i5;
import 'package:ruko/app/gallery/ui/categories/locations_page.dart' as _i13;
import 'package:ruko/app/gallery/ui/categories/months_page.dart' as _i14;
import 'package:ruko/app/gallery/ui/categories/old_photos_first_page.dart'
    as _i15;
import 'package:ruko/app/gallery/ui/categories/shuffled_assets_page.dart'
    as _i20;
import 'package:ruko/app/gallery/ui/categories/videos_only_page.dart' as _i22;
import 'package:ruko/app/gallery/ui/fs_asset_page.dart' as _i9;
import 'package:ruko/app/gallery/ui/generic_swiper_page.dart' as _i10;
import 'package:ruko/app/gallery/ui/home_page.dart' as _i11;
import 'package:ruko/app/permission/permission_request_page.dart' as _i16;
import 'package:ruko/app/root/app_root.dart' as _i4;
import 'package:ruko/app/settings/page/settings_page.dart' as _i18;
import 'package:ruko/app/settings/page/settings_shell_page.dart' as _i19;
import 'package:ruko/app/settings/sections/about_page.dart' as _i1;
import 'package:ruko/app/settings/sections/privacy_policy_page.dart' as _i17;
import 'package:ruko/app/splash_screen/splash_screen.dart' as _i21;
import 'package:ruko/core/error_logger/ui/error_logger_page.dart' as _i7;
import 'package:ruko/core/widgets/alert_widget.dart' as _i25;
import 'package:ruko/core/widgets/common/date_time_picker.dart' as _i6;
import 'package:ruko/core/widgets/common/widgets/styled_alert_dialog.dart'
    as _i3;
import 'package:ruko/core/widgets/info_modals/error_modal.dart' as _i8;
import 'package:ruko/core/widgets/info_modals/info_modal.dart' as _i12;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i23.PageRouteInfo<void> {
  const AboutRoute({List<_i23.PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.AlbumsPage]
class AlbumsRoute extends _i23.PageRouteInfo<void> {
  const AlbumsRoute({List<_i23.PageRouteInfo>? children})
    : super(AlbumsRoute.name, initialChildren: children);

  static const String name = 'AlbumsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i2.AlbumsPage();
    },
  );
}

/// generated route for
/// [_i3.AlertDialogPage]
class AlertDialogRoute extends _i23.PageRouteInfo<AlertDialogRouteArgs> {
  AlertDialogRoute({
    _i24.Key? key,
    required String title,
    String? subtitle,
    _i24.Widget? leading,
    _i24.Widget? trailing,
    void Function(_i24.BuildContext)? onAccept,
    void Function(_i24.BuildContext)? onCancel,
    bool withEasterEgg = true,
    _i25.AlertLevel level = _i25.AlertLevel.warning,
    bool autoPop = false,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         AlertDialogRoute.name,
         args: AlertDialogRouteArgs(
           key: key,
           title: title,
           subtitle: subtitle,
           leading: leading,
           trailing: trailing,
           onAccept: onAccept,
           onCancel: onCancel,
           withEasterEgg: withEasterEgg,
           level: level,
           autoPop: autoPop,
         ),
         initialChildren: children,
       );

  static const String name = 'AlertDialogRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AlertDialogRouteArgs>();
      return _i3.AlertDialogPage(
        key: args.key,
        title: args.title,
        subtitle: args.subtitle,
        leading: args.leading,
        trailing: args.trailing,
        onAccept: args.onAccept,
        onCancel: args.onCancel,
        withEasterEgg: args.withEasterEgg,
        level: args.level,
        autoPop: args.autoPop,
      );
    },
  );
}

class AlertDialogRouteArgs {
  const AlertDialogRouteArgs({
    this.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onAccept,
    this.onCancel,
    this.withEasterEgg = true,
    this.level = _i25.AlertLevel.warning,
    this.autoPop = false,
  });

  final _i24.Key? key;

  final String title;

  final String? subtitle;

  final _i24.Widget? leading;

  final _i24.Widget? trailing;

  final void Function(_i24.BuildContext)? onAccept;

  final void Function(_i24.BuildContext)? onCancel;

  final bool withEasterEgg;

  final _i25.AlertLevel level;

  final bool autoPop;

  @override
  String toString() {
    return 'AlertDialogRouteArgs{key: $key, title: $title, subtitle: $subtitle, leading: $leading, trailing: $trailing, onAccept: $onAccept, onCancel: $onCancel, withEasterEgg: $withEasterEgg, level: $level, autoPop: $autoPop}';
  }
}

/// generated route for
/// [_i4.AppRootPage]
class AppRootRoute extends _i23.PageRouteInfo<AppRootRouteArgs> {
  AppRootRoute({_i24.Key? key, List<_i23.PageRouteInfo>? children})
    : super(
        AppRootRoute.name,
        args: AppRootRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AppRootRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppRootRouteArgs>(
        orElse: () => const AppRootRouteArgs(),
      );
      return _i4.AppRootPage(key: args.key);
    },
  );
}

class AppRootRouteArgs {
  const AppRootRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'AppRootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.CategoriesBottomSheetPage]
class CategoriesBottomSheetRoute extends _i23.PageRouteInfo<void> {
  const CategoriesBottomSheetRoute({List<_i23.PageRouteInfo>? children})
    : super(CategoriesBottomSheetRoute.name, initialChildren: children);

  static const String name = 'CategoriesBottomSheetRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i5.CategoriesBottomSheetPage();
    },
  );
}

/// generated route for
/// [_i6.DateTimePickerBottomSheetPage]
class DateTimePickerBottomSheetRoute
    extends _i23.PageRouteInfo<DateTimePickerBottomSheetRouteArgs> {
  DateTimePickerBottomSheetRoute({
    _i26.Key? key,
    DateTime? initialDate,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         DateTimePickerBottomSheetRoute.name,
         args: DateTimePickerBottomSheetRouteArgs(
           key: key,
           initialDate: initialDate,
         ),
         initialChildren: children,
       );

  static const String name = 'DateTimePickerBottomSheetRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DateTimePickerBottomSheetRouteArgs>(
        orElse: () => const DateTimePickerBottomSheetRouteArgs(),
      );
      return _i6.DateTimePickerBottomSheetPage(
        key: args.key,
        initialDate: args.initialDate,
      );
    },
  );
}

class DateTimePickerBottomSheetRouteArgs {
  const DateTimePickerBottomSheetRouteArgs({this.key, this.initialDate});

  final _i26.Key? key;

  final DateTime? initialDate;

  @override
  String toString() {
    return 'DateTimePickerBottomSheetRouteArgs{key: $key, initialDate: $initialDate}';
  }
}

/// generated route for
/// [_i7.ErrorLoggerPage]
class ErrorLoggerRoute extends _i23.PageRouteInfo<void> {
  const ErrorLoggerRoute({List<_i23.PageRouteInfo>? children})
    : super(ErrorLoggerRoute.name, initialChildren: children);

  static const String name = 'ErrorLoggerRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i7.ErrorLoggerPage();
    },
  );
}

/// generated route for
/// [_i8.ErrorModalPage]
class ErrorModalRoute extends _i23.PageRouteInfo<ErrorModalRouteArgs> {
  ErrorModalRoute({
    _i24.Key? key,
    required String message,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         ErrorModalRoute.name,
         args: ErrorModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'ErrorModalRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorModalRouteArgs>();
      return _i8.ErrorModalPage(key: args.key, message: args.message);
    },
  );
}

class ErrorModalRouteArgs {
  const ErrorModalRouteArgs({this.key, required this.message});

  final _i24.Key? key;

  final String message;

  @override
  String toString() {
    return 'ErrorModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i9.FSAssetPage]
class FSAssetRoute extends _i23.PageRouteInfo<FSAssetRouteArgs> {
  FSAssetRoute({
    _i24.Key? key,
    required _i27.AssetEntity entity,
    required _i27.ThumbnailOption option,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         FSAssetRoute.name,
         args: FSAssetRouteArgs(key: key, entity: entity, option: option),
         initialChildren: children,
       );

  static const String name = 'FSAssetRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FSAssetRouteArgs>();
      return _i9.FSAssetPage(
        key: args.key,
        entity: args.entity,
        option: args.option,
      );
    },
  );
}

class FSAssetRouteArgs {
  const FSAssetRouteArgs({
    this.key,
    required this.entity,
    required this.option,
  });

  final _i24.Key? key;

  final _i27.AssetEntity entity;

  final _i27.ThumbnailOption option;

  @override
  String toString() {
    return 'FSAssetRouteArgs{key: $key, entity: $entity, option: $option}';
  }
}

/// generated route for
/// [_i10.GenericSwiperPage]
class GenericSwiperRoute extends _i23.PageRouteInfo<GenericSwiperRouteArgs> {
  GenericSwiperRoute({
    _i24.Key? key,
    required _i27.AssetPathEntity path,
    List<_i27.AssetEntity> initialAssets = const [],
    String? title,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         GenericSwiperRoute.name,
         args: GenericSwiperRouteArgs(
           key: key,
           path: path,
           initialAssets: initialAssets,
           title: title,
         ),
         initialChildren: children,
       );

  static const String name = 'GenericSwiperRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GenericSwiperRouteArgs>();
      return _i10.GenericSwiperPage(
        key: args.key,
        path: args.path,
        initialAssets: args.initialAssets,
        title: args.title,
      );
    },
  );
}

class GenericSwiperRouteArgs {
  const GenericSwiperRouteArgs({
    this.key,
    required this.path,
    this.initialAssets = const [],
    this.title,
  });

  final _i24.Key? key;

  final _i27.AssetPathEntity path;

  final List<_i27.AssetEntity> initialAssets;

  final String? title;

  @override
  String toString() {
    return 'GenericSwiperRouteArgs{key: $key, path: $path, initialAssets: $initialAssets, title: $title}';
  }
}

/// generated route for
/// [_i11.HomePage]
class HomeRoute extends _i23.PageRouteInfo<void> {
  const HomeRoute({List<_i23.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i11.HomePage();
    },
  );
}

/// generated route for
/// [_i12.InfoModalPage]
class InfoModalRoute extends _i23.PageRouteInfo<InfoModalRouteArgs> {
  InfoModalRoute({
    _i24.Key? key,
    required String message,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         InfoModalRoute.name,
         args: InfoModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'InfoModalRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InfoModalRouteArgs>();
      return _i12.InfoModalPage(key: args.key, message: args.message);
    },
  );
}

class InfoModalRouteArgs {
  const InfoModalRouteArgs({this.key, required this.message});

  final _i24.Key? key;

  final String message;

  @override
  String toString() {
    return 'InfoModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i13.LocationsPage]
class LocationsRoute extends _i23.PageRouteInfo<void> {
  const LocationsRoute({List<_i23.PageRouteInfo>? children})
    : super(LocationsRoute.name, initialChildren: children);

  static const String name = 'LocationsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i13.LocationsPage();
    },
  );
}

/// generated route for
/// [_i14.MonthsPage]
class MonthsRoute extends _i23.PageRouteInfo<void> {
  const MonthsRoute({List<_i23.PageRouteInfo>? children})
    : super(MonthsRoute.name, initialChildren: children);

  static const String name = 'MonthsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i14.MonthsPage();
    },
  );
}

/// generated route for
/// [_i15.OldAssetsFirstPage]
class OldAssetsFirstRoute extends _i23.PageRouteInfo<void> {
  const OldAssetsFirstRoute({List<_i23.PageRouteInfo>? children})
    : super(OldAssetsFirstRoute.name, initialChildren: children);

  static const String name = 'OldAssetsFirstRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i15.OldAssetsFirstPage();
    },
  );
}

/// generated route for
/// [_i16.PermissionRequestPage]
class PermissionRequestRoute extends _i23.PageRouteInfo<void> {
  const PermissionRequestRoute({List<_i23.PageRouteInfo>? children})
    : super(PermissionRequestRoute.name, initialChildren: children);

  static const String name = 'PermissionRequestRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i16.PermissionRequestPage();
    },
  );
}

/// generated route for
/// [_i17.PrivacyPolicyPage]
class PrivacyPolicyRoute extends _i23.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i23.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i17.PrivacyPolicyPage();
    },
  );
}

/// generated route for
/// [_i18.SettingsPage]
class SettingsRoute extends _i23.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i24.Key? key,
    _i28.Future<void> Function()? onLogoutCallback,
    List<_i23.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, onLogoutCallback: onLogoutCallback),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>(
        orElse: () => const SettingsRouteArgs(),
      );
      return _i18.SettingsPage(
        key: args.key,
        onLogoutCallback: args.onLogoutCallback,
      );
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, this.onLogoutCallback});

  final _i24.Key? key;

  final _i28.Future<void> Function()? onLogoutCallback;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, onLogoutCallback: $onLogoutCallback}';
  }
}

/// generated route for
/// [_i19.SettingsShellPage]
class SettingsShellRoute extends _i23.PageRouteInfo<void> {
  const SettingsShellRoute({List<_i23.PageRouteInfo>? children})
    : super(SettingsShellRoute.name, initialChildren: children);

  static const String name = 'SettingsShellRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i19.SettingsShellPage();
    },
  );
}

/// generated route for
/// [_i20.ShuffledAssetsPage]
class ShuffledAssetsRoute extends _i23.PageRouteInfo<void> {
  const ShuffledAssetsRoute({List<_i23.PageRouteInfo>? children})
    : super(ShuffledAssetsRoute.name, initialChildren: children);

  static const String name = 'ShuffledAssetsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i20.ShuffledAssetsPage();
    },
  );
}

/// generated route for
/// [_i21.SplashScreenPage]
class SplashRouteRoute extends _i23.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i23.PageRouteInfo>? children})
    : super(SplashRouteRoute.name, initialChildren: children);

  static const String name = 'SplashRouteRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i21.SplashScreenPage();
    },
  );
}

/// generated route for
/// [_i22.VideosOnlyPage]
class VideosOnlyRoute extends _i23.PageRouteInfo<void> {
  const VideosOnlyRoute({List<_i23.PageRouteInfo>? children})
    : super(VideosOnlyRoute.name, initialChildren: children);

  static const String name = 'VideosOnlyRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i22.VideosOnlyPage();
    },
  );
}
