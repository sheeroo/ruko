// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i19;

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i16;
import 'package:image_delete_demo/app/calendar/calendar_page.dart' as _i4;
import 'package:image_delete_demo/app/calendar/month_swiper.dart' as _i9;
import 'package:image_delete_demo/app/home/home_page.dart' as _i7;
import 'package:image_delete_demo/app/permission_request/permission_request_page.dart'
    as _i10;
import 'package:image_delete_demo/app/root/app_root.dart' as _i3;
import 'package:image_delete_demo/app/settings/page/settings_page.dart' as _i12;
import 'package:image_delete_demo/app/settings/page/settings_shell_page.dart'
    as _i13;
import 'package:image_delete_demo/app/settings/sections/about_page.dart' as _i1;
import 'package:image_delete_demo/app/settings/sections/privacy_policy_page.dart'
    as _i11;
import 'package:image_delete_demo/app/splash_screen/splash_screen.dart' as _i14;
import 'package:image_delete_demo/core/widgets/alert_widget.dart' as _i17;
import 'package:image_delete_demo/core/widgets/common/date_time_picker.dart'
    as _i5;
import 'package:image_delete_demo/core/widgets/common/widgets/styled_alert_dialog.dart'
    as _i2;
import 'package:image_delete_demo/core/widgets/info_modals/error_modal.dart'
    as _i6;
import 'package:image_delete_demo/core/widgets/info_modals/info_modal.dart'
    as _i8;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i15.PageRouteInfo<void> {
  const AboutRoute({List<_i15.PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.AlertDialogPage]
class AlertDialogRoute extends _i15.PageRouteInfo<AlertDialogRouteArgs> {
  AlertDialogRoute({
    _i16.Key? key,
    required String title,
    String? subtitle,
    _i16.Widget? leading,
    _i16.Widget? trailing,
    void Function(_i16.BuildContext)? onAccept,
    void Function(_i16.BuildContext)? onCancel,
    bool withEasterEgg = true,
    _i17.AlertLevel level = _i17.AlertLevel.warning,
    bool autoPop = false,
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
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
    this.level = _i17.AlertLevel.warning,
    this.autoPop = false,
  });

  final _i16.Key? key;

  final String title;

  final String? subtitle;

  final _i16.Widget? leading;

  final _i16.Widget? trailing;

  final void Function(_i16.BuildContext)? onAccept;

  final void Function(_i16.BuildContext)? onCancel;

  final bool withEasterEgg;

  final _i17.AlertLevel level;

  final bool autoPop;

  @override
  String toString() {
    return 'AlertDialogRouteArgs{key: $key, title: $title, subtitle: $subtitle, leading: $leading, trailing: $trailing, onAccept: $onAccept, onCancel: $onCancel, withEasterEgg: $withEasterEgg, level: $level, autoPop: $autoPop}';
  }
}

/// generated route for
/// [_i3.AppRootPage]
class AppRootRoute extends _i15.PageRouteInfo<AppRootRouteArgs> {
  AppRootRoute({_i16.Key? key, List<_i15.PageRouteInfo>? children})
    : super(
        AppRootRoute.name,
        args: AppRootRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AppRootRoute';

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  @override
  String toString() {
    return 'AppRootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.CalendarPage]
class CalendarRoute extends _i15.PageRouteInfo<void> {
  const CalendarRoute({List<_i15.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.CalendarPage();
    },
  );
}

/// generated route for
/// [_i5.DateTimePickerBottomSheetPage]
class DateTimePickerBottomSheetRoute
    extends _i15.PageRouteInfo<DateTimePickerBottomSheetRouteArgs> {
  DateTimePickerBottomSheetRoute({
    _i18.Key? key,
    DateTime? initialDate,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         DateTimePickerBottomSheetRoute.name,
         args: DateTimePickerBottomSheetRouteArgs(
           key: key,
           initialDate: initialDate,
         ),
         initialChildren: children,
       );

  static const String name = 'DateTimePickerBottomSheetRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DateTimePickerBottomSheetRouteArgs>(
        orElse: () => const DateTimePickerBottomSheetRouteArgs(),
      );
      return _i5.DateTimePickerBottomSheetPage(
        key: args.key,
        initialDate: args.initialDate,
      );
    },
  );
}

class DateTimePickerBottomSheetRouteArgs {
  const DateTimePickerBottomSheetRouteArgs({this.key, this.initialDate});

  final _i18.Key? key;

  final DateTime? initialDate;

  @override
  String toString() {
    return 'DateTimePickerBottomSheetRouteArgs{key: $key, initialDate: $initialDate}';
  }
}

/// generated route for
/// [_i6.ErrorModalPage]
class ErrorModalRoute extends _i15.PageRouteInfo<ErrorModalRouteArgs> {
  ErrorModalRoute({
    _i16.Key? key,
    required String message,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ErrorModalRoute.name,
         args: ErrorModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'ErrorModalRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorModalRouteArgs>();
      return _i6.ErrorModalPage(key: args.key, message: args.message);
    },
  );
}

class ErrorModalRouteArgs {
  const ErrorModalRouteArgs({this.key, required this.message});

  final _i16.Key? key;

  final String message;

  @override
  String toString() {
    return 'ErrorModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.InfoModalPage]
class InfoModalRoute extends _i15.PageRouteInfo<InfoModalRouteArgs> {
  InfoModalRoute({
    _i16.Key? key,
    required String message,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         InfoModalRoute.name,
         args: InfoModalRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'InfoModalRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InfoModalRouteArgs>();
      return _i8.InfoModalPage(key: args.key, message: args.message);
    },
  );
}

class InfoModalRouteArgs {
  const InfoModalRouteArgs({this.key, required this.message});

  final _i16.Key? key;

  final String message;

  @override
  String toString() {
    return 'InfoModalRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i9.MonthSwiperPage]
class MonthSwiperRoute extends _i15.PageRouteInfo<MonthSwiperRouteArgs> {
  MonthSwiperRoute({
    _i16.Key? key,
    required String month,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         MonthSwiperRoute.name,
         args: MonthSwiperRouteArgs(key: key, month: month),
         initialChildren: children,
       );

  static const String name = 'MonthSwiperRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MonthSwiperRouteArgs>();
      return _i9.MonthSwiperPage(key: args.key, month: args.month);
    },
  );
}

class MonthSwiperRouteArgs {
  const MonthSwiperRouteArgs({this.key, required this.month});

  final _i16.Key? key;

  final String month;

  @override
  String toString() {
    return 'MonthSwiperRouteArgs{key: $key, month: $month}';
  }
}

/// generated route for
/// [_i10.PermissionRequestPage]
class PermissionRequestRoute extends _i15.PageRouteInfo<void> {
  const PermissionRequestRoute({List<_i15.PageRouteInfo>? children})
    : super(PermissionRequestRoute.name, initialChildren: children);

  static const String name = 'PermissionRequestRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.PermissionRequestPage();
    },
  );
}

/// generated route for
/// [_i11.PrivacyPolicyPage]
class PrivacyPolicyRoute extends _i15.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i15.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.PrivacyPolicyPage();
    },
  );
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i16.Key? key,
    _i19.Future<void> Function()? onLogoutCallback,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, onLogoutCallback: onLogoutCallback),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>(
        orElse: () => const SettingsRouteArgs(),
      );
      return _i12.SettingsPage(
        key: args.key,
        onLogoutCallback: args.onLogoutCallback,
      );
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, this.onLogoutCallback});

  final _i16.Key? key;

  final _i19.Future<void> Function()? onLogoutCallback;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, onLogoutCallback: $onLogoutCallback}';
  }
}

/// generated route for
/// [_i13.SettingsShellPage]
class SettingsShellRoute extends _i15.PageRouteInfo<void> {
  const SettingsShellRoute({List<_i15.PageRouteInfo>? children})
    : super(SettingsShellRoute.name, initialChildren: children);

  static const String name = 'SettingsShellRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SettingsShellPage();
    },
  );
}

/// generated route for
/// [_i14.SplashScreenPage]
class SplashRouteRoute extends _i15.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRouteRoute.name, initialChildren: children);

  static const String name = 'SplashRouteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashScreenPage();
    },
  );
}
