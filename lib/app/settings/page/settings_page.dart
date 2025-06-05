import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/widgets/common/context_menu/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, this.onLogoutCallback});
  final Future<void> Function()? onLogoutCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        body: ContextMenuPage(
          items: [
            MenuItem(
              icon: FeatherIcons.user,
              title: 'profile',
              onTap: () {
                // context.router.push(const ProfileRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.barChart,
              title: 'stats',
              onTap: () {
                // context.router.push(const ProfileRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.info,
              title: 'about',
              onTap: () {
                // context.router.push(const AboutRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.shield,
              title: 'privacy policy',
              onTap: () {
                // context.router.push(const PrivacyPolicyRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.download,
              title: 'data export',
              onTap: () {
                // context.router.push(const DataExportRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.userX,
              title: 'delete account',
              onTap: () {
                // context.router.push(const DeleteAccountRoute());
              },
            ),
            MenuItem(
              icon: FeatherIcons.send,
              title: 'send feedback',
              onTap: () {
                // final mailTo = Mailto(
                //   to: [RemoteConfigRepository.instance.data.feedbackMail],
                //   subject: 'my thoughts about whoami',
                //   body: 'got any ideas or things you wanna share? let me know!',
                // );
                // launchUrl(mailTo.toString().toUri);
              },
            ),
          ],
        ),
      ).blur(32),
    );
  }
}
