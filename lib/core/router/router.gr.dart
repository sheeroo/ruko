// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i23;

import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/cupertino.dart' as _i21;
import 'package:flutter/material.dart' as _i19;
import 'package:image_delete_demo/app/categories/categories_page.dart' as _i4;
import 'package:image_delete_demo/app/categories/categories_swiper_page.dart'
    as _i5;
import 'package:image_delete_demo/app/categories/category_page.dart' as _i6;
import 'package:image_delete_demo/app/gallery_assets/image_full_screen.dart'
    as _i10;
import 'package:image_delete_demo/app/gallery_assets/video_full_screen.dart'
    as _i17;
import 'package:image_delete_demo/app/home/home_page.dart' as _i9;
import 'package:image_delete_demo/app/permission_request/permission_request_page.dart'
    as _i12;
import 'package:image_delete_demo/app/root/app_root.dart' as _i3;
import 'package:image_delete_demo/app/settings/page/settings_page.dart' as _i14;
import 'package:image_delete_demo/app/settings/page/settings_shell_page.dart'
    as _i15;
import 'package:image_delete_demo/app/settings/sections/about_page.dart' as _i1;
import 'package:image_delete_demo/app/settings/sections/privacy_policy_page.dart'
    as _i13;
import 'package:image_delete_demo/app/splash_screen/splash_screen.dart' as _i16;
import 'package:image_delete_demo/core/widgets/alert_widget.dart' as _i20;
import 'package:image_delete_demo/core/widgets/common/date_time_picker.dart'
    as _i7;
import 'package:image_delete_demo/core/widgets/common/widgets/styled_alert_dialog.dart'
    as _i2;
import 'package:image_delete_demo/core/widgets/info_modals/error_modal.dart'
    as _i8;
import 'package:image_delete_demo/core/widgets/info_modals/info_modal.dart'
    as _i11;
import 'package:photo_manager/photo_manager.dart' as _i22;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i18.PageRouteInfo<void> {
  const AboutRoute({List<_i18.PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.AlertDialogPage]
class AlertDialogRoute extends _i18.PageRouteInfo<AlertDialogRouteArgs> {
  AlertDialogRoute({
    _i19.Key? key,
    required String title,
    String? subtitle,
    _i19.Widget? leading,
    _i19.Widget? trailing,
    void Function(_i19.BuildContext)? onAccept,
    void Function(_i19.BuildContext)? onCancel,
    bool withEasterEgg = true,
    _i20.AlertLevel level = _i20.AlertLevel.warning,
    bool autoPop = false,
    List<_i18.PageRouteInfo>? children,
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

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AlertDialogRouteArgs>();
      return _i2.AlertDialogPage(
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
    this.level = _i20.AlertLevel.warning,
    this.autoPop = false,
  });

  final _i19.Key? key;

  final String title;

  final String? subtitle;

  final _i19.Widget? leading;

  final _i19.Widget? trailing;

  final void Function(_i19.BuildContext)? onAccept;

  final void Function(_i19.BuildContext)? onCancel;

  final bool withEasterEgg;

  final _i20.AlertLevel level;

  final bool autoPop;

  @override
  String toString() {
    return 'AlertDialogRouteArgs{key: $key, title: $title, subtitle: $subtitle, leading: $leading, trailing: $trailing, onAccept: $onAccept, onCancel: $onCancel, withEasterEgg: $withEasterEgg, level: $level, autoPop: $autoPop}';
  }
}

/// generated route for
/// [_i3.AppRootPage]
class AppRootRoute extends _i18.PageRouteInfo<AppRootRouteArgs> {
  AppRootRoute({_i19.Key? key, List<_i18.PageRouteInfo>? children})
    : super(
        AppRootRoute.name,
        args: AppRootRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AppRootRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppRootRouteArgs>(
        orElse: () => const AppRootRouteArgs(),
      );
      return _i3.AppRootPage(key: args.key);
    },
  );
}

class AppRootRouteArgs {
  const AppRootRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'AppRootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.CategoriesPage]
class CategoriesRoute extends _i18.PageRouteInfo<void> {
  const CategoriesRoute({List<_i18.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i5.CategoriesSwiperPage]
class CategoriesSwiperRoute
    extends _i18.PageRouteInfo<CategoriesSwiperRouteArgs> {
  CategoriesSwiperRoute({
    _i19.Key? key,
    required List<String> ids,
    required String title,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         CategoriesSwiperRoute.name,
         args: CategoriesSwiperRouteArgs(key: key, ids: ids, title: title),
         initialChildren: children,
       );

  static const String name = 'CategoriesSwiperRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoriesSwiperRouteArgs>();
      return _i5.CategoriesSwiperPage(
        key: args.key,
        ids: args.ids,
        title: args.title,
      );
    },
  );
}

class CategoriesSwiperRouteArgs {
  const CategoriesSwiperRouteArgs({
    this.key,
    required this.ids,
    required this.title,
  });

  final _i19.Key? key;

  final List<String> ids;

  final String title;

  @override
  String toString() {
    return 'CategoriesSwiperRouteArgs{key: $key, ids: $ids, title: $title}';
  }
}

/// generated route for
/// [_i6.CategoryPage]
class CategoryRoute extends _i18.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i19.Key? key,
    required _i4.AssetCategory category,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         CategoryRoute.name,
         args: CategoryRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'CategoryRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return _i6.CategoryPage(key: args.key, category: args.category);
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.category});

  final _i19.Key? key;

  final _i4.AssetCategory category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i7.DateTimePickerBottomSheetPage]
class DateTimePickerBottomSheetRoute
    extends _i18.PageRouteInfo<DateTimePickerBottomSheetRouteArgs> {
  DateTimePickerBottomSheetRoute({
    _i21.Key? key,
    DateTime? initialDate,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         DateTimePickerBottomSheetRoute.name,
         args: DateTimePickerBottomSheetRouteArgs(
           key: key,
           initialDate: initialDate,
         ),
         initialChildren: children,
       );

  static const String name = 'DateTimePickerBottomSheetRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DateTimePickerBottomSheetRouteArgs>(
        orElse: () => const DateTimePickerBottomSheetRouteArgs(),
      );
      return _i7.DateTimePickerBottomSheetPage(
        key: args.key,
        initialDate: args.initialDate,
      );
    },
  );
}

class DateTimePickerBottomSheetRouteArgs {
  const DateTimePickerBottomSheetRouteArgs({this.key, this.initialDate});

  final _i21.Key? key;

  final DateTime? initialDate;

  @override
  String toString() {
    return 'DateTimePickerBottomSheetRouteArgs{key: $key, initialDate: $initialDate}';
  }
}

/// generated route for
/// [_i8.ErrorModalPage]
class ErrorModalRoute extends _i18.PageRouteInfo<ErrorModalRouteArgs> {
  ErrorModalRoute({
    _i19.Key? key,
    required String message,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         ErrorModalRoute.name,
         args: ErrorModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'ErrorModalRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorModalRouteArgs>();
      return _i8.ErrorModalPage(key: args.key, message: args.message);
    },
  );
}

class ErrorModalRouteArgs {
  const ErrorModalRouteArgs({this.key, required this.message});

  final _i19.Key? key;

  final String message;

  @override
  String toString() {
    return 'ErrorModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.HomePage();
    },
  );
}

/// generated route for
/// [_i10.ImageFullPage]
class ImageFullRoute extends _i18.PageRouteInfo<ImageFullRouteArgs> {
  ImageFullRoute({
    _i19.Key? key,
    required _i22.AssetEntity entity,
    required _i22.ThumbnailOption option,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         ImageFullRoute.name,
         args: ImageFullRouteArgs(key: key, entity: entity, option: option),
         initialChildren: children,
       );

  static const String name = 'ImageFullRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageFullRouteArgs>();
      return _i10.ImageFullPage(
        key: args.key,
        entity: args.entity,
        option: args.option,
      );
    },
  );
}

class ImageFullRouteArgs {
  const ImageFullRouteArgs({
    this.key,
    required this.entity,
    required this.option,
  });

  final _i19.Key? key;

  final _i22.AssetEntity entity;

  final _i22.ThumbnailOption option;

  @override
  String toString() {
    return 'ImageFullRouteArgs{key: $key, entity: $entity, option: $option}';
  }
}

/// generated route for
/// [_i11.InfoModalPage]
class InfoModalRoute extends _i18.PageRouteInfo<InfoModalRouteArgs> {
  InfoModalRoute({
    _i19.Key? key,
    required String message,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         InfoModalRoute.name,
         args: InfoModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'InfoModalRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InfoModalRouteArgs>();
      return _i11.InfoModalPage(key: args.key, message: args.message);
    },
  );
}

class InfoModalRouteArgs {
  const InfoModalRouteArgs({this.key, required this.message});

  final _i19.Key? key;

  final String message;

  @override
  String toString() {
    return 'InfoModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i12.PermissionRequestPage]
class PermissionRequestRoute extends _i18.PageRouteInfo<void> {
  const PermissionRequestRoute({List<_i18.PageRouteInfo>? children})
    : super(PermissionRequestRoute.name, initialChildren: children);

  static const String name = 'PermissionRequestRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.PermissionRequestPage();
    },
  );
}

/// generated route for
/// [_i13.PrivacyPolicyPage]
class PrivacyPolicyRoute extends _i18.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i18.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.PrivacyPolicyPage();
    },
  );
}

/// generated route for
/// [_i14.SettingsPage]
class SettingsRoute extends _i18.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i19.Key? key,
    _i23.Future<void> Function()? onLogoutCallback,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, onLogoutCallback: onLogoutCallback),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>(
        orElse: () => const SettingsRouteArgs(),
      );
      return _i14.SettingsPage(
        key: args.key,
        onLogoutCallback: args.onLogoutCallback,
      );
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, this.onLogoutCallback});

  final _i19.Key? key;

  final _i23.Future<void> Function()? onLogoutCallback;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, onLogoutCallback: $onLogoutCallback}';
  }
}

/// generated route for
/// [_i15.SettingsShellPage]
class SettingsShellRoute extends _i18.PageRouteInfo<void> {
  const SettingsShellRoute({List<_i18.PageRouteInfo>? children})
    : super(SettingsShellRoute.name, initialChildren: children);

  static const String name = 'SettingsShellRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsShellPage();
    },
  );
}

/// generated route for
/// [_i16.SplashScreenPage]
class SplashRouteRoute extends _i18.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i18.PageRouteInfo>? children})
    : super(SplashRouteRoute.name, initialChildren: children);

  static const String name = 'SplashRouteRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.SplashScreenPage();
    },
  );
}

/// generated route for
/// [_i17.VideoFullPage]
class VideoFullRoute extends _i18.PageRouteInfo<VideoFullRouteArgs> {
  VideoFullRoute({
    _i19.Key? key,
    required _i22.AssetEntity entity,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         VideoFullRoute.name,
         args: VideoFullRouteArgs(key: key, entity: entity),
         initialChildren: children,
       );

  static const String name = 'VideoFullRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoFullRouteArgs>();
      return _i17.VideoFullPage(key: args.key, entity: args.entity);
    },
  );
}

class VideoFullRouteArgs {
  const VideoFullRouteArgs({this.key, required this.entity});

  final _i19.Key? key;

  final _i22.AssetEntity entity;

  @override
  String toString() {
    return 'VideoFullRouteArgs{key: $key, entity: $entity}';
  }
}
