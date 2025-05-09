import 'package:rate_limiter/rate_limiter.dart' as rate_limiter;

class Throttler {
  Throttler(this.duration);
  final Duration duration;

  late final _throttle = rate_limiter.throttle(
    (void Function() callback) {
      callback();
    },
    duration,
  );

  void run(void Function() callback) {
    _throttle([callback]);
  }
}
