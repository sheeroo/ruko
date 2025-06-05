import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ruko/core/app_info/app_info.dart';
import 'package:ruko/core/di/service_locator.dart';
import 'package:ruko/core/flavors.dart';
import 'package:ruko/core/share/installed_apps_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
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
    final directory = HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    );
    final storage = await HydratedStorage.build(storageDirectory: directory);
    HydratedBloc.storage = storage;
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
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupServiceLocator();
    sl<InstalledAppsRepository>().loadInstalledApps();
    if (kDebugMode) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    tz.initializeTimeZones();

    runApp(await builder());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
