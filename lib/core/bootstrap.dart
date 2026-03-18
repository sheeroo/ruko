import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ruko/core/app_info/app_info.dart';
import 'package:ruko/core/di/service_locator.dart';
import 'package:ruko/core/dotenv/dotenv.dart';
import 'package:ruko/core/error_logger/error_log.dart';
import 'package:ruko/core/error_logger/error_logger.dart';
import 'package:ruko/core/flavors.dart';
import 'package:ruko/core/share/installed_apps_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    ErrorLogger.instance.capture(
      message: error.toString(),
      source: ErrorSource.bloc,
      severity: ErrorSeverity.error,
      error: error,
      stackTrace: stackTrace,
      context: bloc.runtimeType.toString(),
    );
    super.onError(bloc, error, stackTrace);
  }
}

class Bootstrap {
  Bootstrap._();

  static final instance = Bootstrap._();

  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> get ensureInitialized => _completer.future;
  final _completer = Completer<void>();

  Future<void> initialize() async {
    await AppInfo.instance.loadAppInfo();
    _initialized = true;
    _completer.complete();
  }

  static Future<void> development(FutureOr<Widget> Function() builder) =>
      bootstrap(builder, flavor: Flavor.development);
  static Future<void> staging(FutureOr<Widget> Function() builder) =>
      bootstrap(builder, flavor: Flavor.staging);
  static Future<void> production(FutureOr<Widget> Function() builder) =>
      bootstrap(builder, flavor: Flavor.production);
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required Flavor flavor,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
    ErrorLogger.instance.capture(
      message: details.exceptionAsString(),
      source: ErrorSource.flutter,
      severity: ErrorSeverity.error,
      error: details.exception,
      stackTrace: details.stack,
      context: details.library,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
    ErrorLogger.instance.capture(
      message: error.toString(),
      source: ErrorSource.platform,
      severity: ErrorSeverity.error,
      error: error,
      stackTrace: stackTrace,
    );
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Bootstrap.instance.initialize();
      await setupServiceLocator();
      sl<InstalledAppsRepository>().loadInstalledApps();
      DotEnv.instance.load();
      if (kDebugMode) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
      tz.initializeTimeZones();

      runApp(await builder());
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      ErrorLogger.instance.capture(
        message: error.toString(),
        source: ErrorSource.zone,
        severity: ErrorSeverity.error,
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}
