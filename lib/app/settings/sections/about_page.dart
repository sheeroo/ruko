import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruko/core/app_info/app_info.dart';
import 'package:ruko/core/error_logger/error_log.dart';
import 'package:ruko/core/error_logger/error_logger.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _versionTapCount = 0;
  static const int _tapsRequired = 7;

  void _onVersionTap() {
    HapticFeedback.selectionClick();
    try {
      throw Exception('Test exception from AboutPage version tap');
    } catch (ex, stack) {
      ErrorLogger.instance.capture(
        message: ex.toString(),
        source: ErrorSource.flutter,
        severity: ErrorSeverity.error,
        error: ex,
        stackTrace: stack,
        context: 'AboutPage version tap',
      );
    }
    setState(() => _versionTapCount++);

    if (_versionTapCount >= _tapsRequired) {
      _versionTapCount = 0;
      context.router.push(const ErrorLoggerRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'ruko.'),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              const AboutItem(
                title: 'what is ruko?',
                subtitle:
                    'ruko turns cleaning your camera roll into a game. swipe right to keep, swipe left to delete. no more endless scrolling through thousands of photos — just fast, satisfying decisions.',
              ),
              const AboutItem(
                title: 'how does it work?',
                subtitle:
                    'your photos are loaded directly from your device and shown as swipeable cards. nothing ever leaves your phone. ruko never uploads, syncs or shares your media.',
              ),
              const AboutItem(
                title: 'is it free?',
                subtitle:
                    'yes, and it will stay free. no ads, no subscriptions, no hidden fees.',
              ),
              const AboutItem(
                title: 'your data',
                subtitle:
                    'ruko only reads photos you already have on your device. it collects zero personal information, has no analytics and communicates with no external servers.',
              ),
              GestureDetector(
                onTap: _onVersionTap,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('> version').bodySmall(fontSize: 11),
                    const Gap(10),
                    Text(
                      '${AppInfo.instance.packageInfo.version}+${AppInfo.instance.packageInfo.buildNumber}',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 10,
                        color: Colors.white.withValues(alpha: 0.45),
                        height: 2.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).p(all: 20),
        ),
      ),
    );
  }
}

class AboutItem extends StatelessWidget {
  const AboutItem({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('> $title').bodySmall(fontSize: 11),
        const Gap(10),
        Text(
          subtitle,
          style: GoogleFonts.pressStart2p(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.45),
            height: 2.2,
          ),
        ),
      ],
    );
  }
}
