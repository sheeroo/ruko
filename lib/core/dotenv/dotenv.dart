import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ruko/core/di/service_locator.dart';

class DotEnv {
  bool _loaded = false;
  bool get isLoaded => _loaded;
  static final DotEnv instance = sl<DotEnv>();

  String get fbAppId {
    assert(
      _loaded,
      'DotEnv is not loaded. Call load() before accessing environment variables.',
    );
    return dotenv.env['FB_APP_ID']!;
  }

  Future<void> load() async {
    await dotenv.load(fileName: '.env');
    _loaded = true;
  }
}
