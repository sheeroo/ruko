import 'dart:async';

import 'package:ruko/core/error_logger/error_log.dart';

class ErrorLogger {
  ErrorLogger._();

  static final ErrorLogger instance = ErrorLogger._();

  static const int _maxLogs = 500;

  final List<ErrorLog> _logs = [];
  final _controller = StreamController<List<ErrorLog>>.broadcast();

  List<ErrorLog> get logs => List.unmodifiable(_logs);
  Stream<List<ErrorLog>> get stream => _controller.stream;
  int get count => _logs.length;
  int get errorCount => _logs.where((l) => l.severity == ErrorSeverity.error).length;
  int get warningCount => _logs.where((l) => l.severity == ErrorSeverity.warning).length;
  int get infoCount => _logs.where((l) => l.severity == ErrorSeverity.info).length;

  void capture({
    required String message,
    ErrorSeverity severity = ErrorSeverity.error,
    ErrorSource source = ErrorSource.manual,
    Object? error,
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? metadata,
  }) {
    final log = ErrorLog(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      timestamp: DateTime.now(),
      severity: severity,
      source: source,
      message: message,
      errorType: error?.runtimeType.toString(),
      stackTrace: stackTrace?.toString(),
      context: context,
      metadata: metadata,
    );

    if (_logs.length >= _maxLogs) _logs.removeLast();
    _logs.insert(0, log);
    _controller.add(List.unmodifiable(_logs));
  }

  void clear() {
    _logs.clear();
    _controller.add(const []);
  }
}
