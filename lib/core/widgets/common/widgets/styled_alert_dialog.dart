import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/button.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:ruko/core/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class AlertDialogPage extends StatelessWidget {
  const AlertDialogPage({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onAccept,
    this.onCancel,
    this.withEasterEgg = true,
    this.level = AlertLevel.warning,
    this.autoPop = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final void Function(BuildContext)? onAccept;
  final void Function(BuildContext)? onCancel;
  final bool withEasterEgg;
  final AlertLevel level;
  final bool autoPop;

  @override
  Widget build(BuildContext context) {
    return StyledAlertDialog(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onAccept: onAccept,
      onCancel: onCancel,
      withEasterEgg: withEasterEgg,
      level: level,
      autoPop: autoPop,
    );
  }
}

class StyledAlertDialog extends StatelessWidget {
  const StyledAlertDialog({
    super.key,
    required this.title,
    this.withEasterEgg = true,
    this.subtitle,
    this.onAccept,
    this.onCancel,
    this.leading,
    this.trailing,
    this.level = AlertLevel.warning,
    this.autoPop = false,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final AlertLevel level;
  final String? subtitle;
  final bool withEasterEgg;
  final void Function(BuildContext)? onAccept;
  final void Function(BuildContext)? onCancel;
  final bool autoPop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.maybePop(),
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.15),
        body: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (leading != null) leading!,
                          Flexible(child: Alert(message: title, level: level)),
                          if (trailing != null) trailing!,
                        ],
                      ),
                      if (subtitle != null) ...[
                        const Gap(12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                subtitle!,
                                overflow: TextOverflow.ellipsis,
                              ).bodySmall(opacity: 0.5),
                            ),
                          ),
                        ),
                      ],
                      const Gap(64),
                      Row(
                        spacing: 32,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StyledButton.text(
                            onPressed: () {
                              if (onCancel != null) {
                                if (autoPop) {
                                  context.router.maybePop(false);
                                }
                                return onCancel!(context);
                              }
                              context.router.maybePop(false);
                            },
                            fontColor: Colors.white.withValues(alpha: 0.6),
                            title: "cancel",
                          ),
                          StyledButton.text(
                            onPressed: () async {
                              if (onAccept != null) {
                                if (autoPop) {
                                  await context.router.maybePop(true);
                                }
                                if (!context.mounted) return;

                                return onAccept!(context);
                              }
                              context.router.maybePop(true);
                            },
                            title: "yes.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).blur(64);
  }
}
