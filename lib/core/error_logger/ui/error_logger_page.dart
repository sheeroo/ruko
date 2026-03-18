import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruko/core/error_logger/error_log.dart';
import 'package:ruko/core/error_logger/error_logger.dart';

@RoutePage()
class ErrorLoggerPage extends StatefulWidget {
  const ErrorLoggerPage({super.key});

  @override
  State<ErrorLoggerPage> createState() => _ErrorLoggerPageState();
}

class _ErrorLoggerPageState extends State<ErrorLoggerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<ErrorLog>>(
        stream: ErrorLogger.instance.stream,
        initialData: ErrorLogger.instance.logs,
        builder: (context, snapshot) {
          final logs = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              _buildAppBar(context, logs),
              _buildStats(logs),
              logs.isEmpty ? _buildEmptyState() : _buildLogList(logs),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, List<ErrorLog> logs) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          Text(
            'sys.log',
            style: GoogleFonts.pressStart2p(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          if (logs.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _severityColor(
                  ErrorSeverity.error,
                ).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: _severityColor(
                    ErrorSeverity.error,
                  ).withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                '${logs.length}',
                style: GoogleFonts.pressStart2p(
                  color: _severityColor(ErrorSeverity.error),
                  fontSize: 9,
                ),
              ),
            ),
        ],
      ),
      actions: [
        if (logs.isNotEmpty)
          TextButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              ErrorLogger.instance.clear();
            },
            child: Text(
              'clear',
              style: GoogleFonts.pressStart2p(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 9,
              ),
            ),
          ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
    );
  }

  Widget _buildStats(List<ErrorLog> logs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Row(
          children: [
            _StatChip(
              label: 'errors',
              count: ErrorLogger.instance.errorCount,
              color: _severityColor(ErrorSeverity.error),
            ),
            const SizedBox(width: 8),
            _StatChip(
              label: 'warns',
              count: ErrorLogger.instance.warningCount,
              color: _severityColor(ErrorSeverity.warning),
            ),
            const SizedBox(width: 8),
            _StatChip(
              label: 'info',
              count: ErrorLogger.instance.infoCount,
              color: _severityColor(ErrorSeverity.info),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '// no logs',
              style: GoogleFonts.pressStart2p(
                color: Colors.white.withValues(alpha: 0.15),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'system is quiet.',
              style: GoogleFonts.pressStart2p(
                color: Colors.white.withValues(alpha: 0.08),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogList(List<ErrorLog> logs) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      sliver: SliverList.separated(
        itemCount: logs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return _ErrorLogCard(log: logs[index]);
        },
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$count $label',
            style: GoogleFonts.pressStart2p(
              color: color,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorLogCard extends StatefulWidget {
  const _ErrorLogCard({required this.log});

  final ErrorLog log;

  @override
  State<_ErrorLogCard> createState() => _ErrorLogCardState();
}

class _ErrorLogCardState extends State<_ErrorLogCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final log = widget.log;
    final color = _severityColor(log.severity);

    return GestureDetector(
      onTap: log.stackTrace != null
          ? () {
              HapticFeedback.selectionClick();
              setState(() => _expanded = !_expanded);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored left border
              Container(
                width: 3,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(log, color),
                      const SizedBox(height: 8),
                      _buildMessage(log),
                      if (log.context != null) ...[
                        const SizedBox(height: 6),
                        _buildContext(log.context!),
                      ],
                      if (log.metadata != null && log.metadata!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _buildMetadata(log.metadata!),
                      ],
                      if (_expanded && log.stackTrace != null) ...[
                        const SizedBox(height: 10),
                        _buildDivider(),
                        const SizedBox(height: 10),
                        _buildStackTrace(log.stackTrace!),
                      ],
                      if (log.stackTrace != null) ...[
                        const SizedBox(height: 8),
                        _buildExpandHint(color),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ErrorLog log, Color color) {
    return Row(
      children: [
        _SeverityBadge(severity: log.severity),
        const SizedBox(width: 6),
        _SourceBadge(source: log.source),
        const Spacer(),
        Text(
          log.formattedTime,
          style: GoogleFonts.pressStart2p(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 7,
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(ErrorLog log) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (log.errorType != null) ...[
          Text(
            log.errorType!,
            style: GoogleFonts.pressStart2p(
              color: _severityColor(log.severity).withValues(alpha: 0.8),
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Text(
          log.message,
          style: GoogleFonts.pressStart2p(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 8,
            height: 1.7,
          ),
        ),
      ],
    );
  }

  Widget _buildContext(String context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        '@ $context',
        style: GoogleFonts.pressStart2p(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 7,
        ),
      ),
    );
  }

  Widget _buildMetadata(Map<String, dynamic> metadata) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: metadata.entries.map((e) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '${e.key}: ${e.value}',
            style: GoogleFonts.pressStart2p(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 6,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white.withValues(alpha: 0.08),
    );
  }

  Widget _buildStackTrace(String stackTrace) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'stack trace',
              style: GoogleFonts.pressStart2p(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 7,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: stackTrace));
                HapticFeedback.lightImpact();
              },
              child: Text(
                'copy',
                style: GoogleFonts.pressStart2p(
                  color: Colors.white.withValues(alpha: 0.25),
                  fontSize: 7,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
          ),
          child: SelectableText(
            stackTrace,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 9,
              color: Colors.white.withValues(alpha: 0.55),
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandHint(Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        _expanded ? '▲ collapse' : '▼ stack trace',
        style: GoogleFonts.pressStart2p(
          color: color.withValues(alpha: 0.45),
          fontSize: 7,
        ),
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({required this.severity});

  final ErrorSeverity severity;

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(severity);
    final label = switch (severity) {
      ErrorSeverity.error => 'ERR',
      ErrorSeverity.warning => 'WARN',
      ErrorSeverity.info => 'INFO',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.pressStart2p(
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SourceBadge extends StatelessWidget {
  const _SourceBadge({required this.source});

  final ErrorSource source;

  @override
  Widget build(BuildContext context) {
    final color = _sourceColor(source);
    final label = switch (source) {
      ErrorSource.bloc => 'BLOC',
      ErrorSource.flutter => 'FLUTTER',
      ErrorSource.platform => 'PLATFORM',
      ErrorSource.zone => 'ZONE',
      ErrorSource.manual => 'MANUAL',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.pressStart2p(
          color: color,
          fontSize: 7,
        ),
      ),
    );
  }
}

Color _severityColor(ErrorSeverity severity) => switch (severity) {
  ErrorSeverity.error => const Color(0xFFFF4757),
  ErrorSeverity.warning => const Color(0xFFFFD32A),
  ErrorSeverity.info => const Color(0xFF2ED573),
};

Color _sourceColor(ErrorSource source) => switch (source) {
  ErrorSource.bloc => const Color(0xFF5352ED),
  ErrorSource.flutter => const Color(0xFF54A0FF),
  ErrorSource.platform => const Color(0xFF1DD1A1),
  ErrorSource.zone => const Color(0xFFFF9F43),
  ErrorSource.manual => const Color(0xFFA4B0BE),
};
