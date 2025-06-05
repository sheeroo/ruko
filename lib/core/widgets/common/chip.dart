import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DriftChip extends StatelessWidget {
  const DriftChip({
    super.key,
    required this.text,
    required this.icon,
    this.scaleFactor = 1,
    this.color,
    this.onTap,
    this.onDelete,
    this.onRetry,
    this.loading = false,
    this.error = false,
  });

  final String text;
  final IconData icon;
  final double scaleFactor;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onDelete;
  final void Function()? onRetry;
  final bool loading;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      onLongPress: () {
        onRetry?.call();
      },
      child: AnimatedOpacity(
        duration: Durations.medium1,
        curve: Curves.fastOutSlowIn,
        opacity: loading ? 0.5 : 1,
        child: Container(
          constraints: BoxConstraints(maxWidth: 225),
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4 * scaleFactor,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                icon,
                color: (color ?? Colors.white).withValues(
                  alpha: error ? 0.5 : 1,
                ),
                size: 14 * scaleFactor,
              ).fallback(
                SizedBox(
                  height: 14 * scaleFactor,
                  width: 14 * scaleFactor,
                  child: CupertinoActivityIndicator(radius: 8),
                ),
                when: loading,
              ),
              Flexible(
                child: Text(
                  text.toLowerCase(),
                  overflow: TextOverflow.ellipsis,
                ).bodySmall(
                  fontSize: 12 * scaleFactor,
                  color: color ?? Colors.white,
                  opacity: error ? 0.5 : 1,
                ),
              ),
              if (onDelete != null && !loading)
                GestureDetector(
                  onTap: () {
                    onDelete?.call();
                  },
                  child: Icon(
                    FeatherIcons.x,
                    color: color ?? Colors.white,
                    size: 14 * scaleFactor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
