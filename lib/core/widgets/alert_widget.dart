import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/theme/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

enum AlertLevel { info, success, warning, error }

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.message,
    required this.level,
    this.secondaryMessage,
  });

  final String message;
  final String? secondaryMessage;
  final AlertLevel level;

  factory Alert.info(String message, {String? secondaryMessage}) {
    return Alert(
      message: message,
      level: AlertLevel.info,
      secondaryMessage: secondaryMessage,
    );
  }

  factory Alert.success(String message, {String? secondaryMessage}) {
    return Alert(
      message: message,
      level: AlertLevel.success,
      secondaryMessage: secondaryMessage,
    );
  }

  factory Alert.warning(String message, {String? secondaryMessage}) {
    return Alert(
      message: message,
      level: AlertLevel.warning,
      secondaryMessage: secondaryMessage,
    );
  }

  factory Alert.error(String message, {String? secondaryMessage}) {
    return Alert(
      message: message,
      level: AlertLevel.error,
      secondaryMessage: secondaryMessage,
    );
  }

  Color get color {
    switch (level) {
      case AlertLevel.info:
        return Colors.white;
      case AlertLevel.success:
        return Colors.green.shade400;
      case AlertLevel.warning:
        return Colors.orange.shade400;
      case AlertLevel.error:
        return Colors.red.shade400;
    }
  }

  Color get tileColor {
    switch (level) {
      case AlertLevel.info:
        return Colors.white.withValues(alpha: 0.1);
      case AlertLevel.success:
        return Colors.green.withValues(alpha: 0.1);
      case AlertLevel.warning:
        return Colors.orange.withValues(alpha: 0.1);
      case AlertLevel.error:
        return Colors.red.withValues(alpha: 0.1);
    }
  }

  IconData get icon {
    switch (level) {
      case AlertLevel.info:
        return FeatherIcons.info;
      case AlertLevel.success:
        return FeatherIcons.checkCircle;
      case AlertLevel.warning:
        return FeatherIcons.alertTriangle;
      case AlertLevel.error:
        return FeatherIcons.alertCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            tileColor: tileColor,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              side: BorderSide(
                color: color.withValues(alpha: 0.25),
                width: 0.5,
              ),
            ),
            leading: Icon(icon, color: color, size: 16),
            title: Text(message).bodySmall(color: color),
          ),
          if (secondaryMessage != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                secondaryMessage!,
              ).bodySmall(opacity: 0.75).p(horizontal: 8, top: 12),
            ),
        ],
      ),
    );
  }
}
