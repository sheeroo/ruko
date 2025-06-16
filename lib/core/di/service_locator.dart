import 'package:get_it/get_it.dart';
import 'package:ruko/core/dotenv/dotenv.dart';
import 'package:ruko/core/share/installed_apps_repository.dart';

/// Global ServiceLocator instance
final GetIt sl = GetIt.instance;

/// Initialize service locator for production environment
Future<void> setupServiceLocator() async {
  sl.registerLazySingleton(() => InstalledAppsRepository());
  sl.registerLazySingleton(() => DotEnv());
}
