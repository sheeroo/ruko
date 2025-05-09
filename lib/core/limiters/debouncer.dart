import 'package:rate_limiter/rate_limiter.dart';

class Debouncer {
  Debouncer(this.duration);
  final Duration duration;
  late final _debounce = debounce(
    (void Function() callback) {
      callback();
    },
    duration,
  );

  void run(void Function() action) {
    _debounce([action]);
  }
}
