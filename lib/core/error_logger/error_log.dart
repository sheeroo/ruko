enum ErrorSeverity { info, warning, error }

enum ErrorSource { bloc, flutter, platform, zone, manual }

class ErrorLog {
  ErrorLog({
    required this.id,
    required this.timestamp,
    required this.severity,
    required this.source,
    required this.message,
    this.errorType,
    this.stackTrace,
    this.context,
    this.metadata,
  });

  final String id;
  final DateTime timestamp;
  final ErrorSeverity severity;
  final ErrorSource source;
  final String message;
  final String? errorType;
  final String? stackTrace;
  final String? context;
  final Map<String, dynamic>? metadata;

  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }

  String get formattedTime {
    final h = timestamp.hour.toString().padLeft(2, '0');
    final m = timestamp.minute.toString().padLeft(2, '0');
    final s = timestamp.second.toString().padLeft(2, '0');
    final ms = timestamp.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}
