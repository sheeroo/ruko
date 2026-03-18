import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ruko/app/gallery/cubit/asset_paths_cubit.dart';
import 'package:ruko/core/error_logger/error_log.dart';
import 'package:ruko/core/error_logger/error_logger.dart';
import 'package:ruko/core/router/router.gr.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      try {
        // await Bootstrap.instance.initialize();
        final status = await Permission.photos.status;
        if (status.isGranted) {
          if (!mounted) return;
          await context.read<AssetPathsCubit>().loadPaths();
          if (!mounted) return;
          context.router.replaceAll([HomeRoute()]);
        } else {
          if (!mounted) return;
          context.router.replaceAll([PermissionRequestRoute()]);
        }
      } catch (e, st) {
        ErrorLogger.instance.capture(
          message: 'Splash screen initialization failed.',
          source: ErrorSource.manual,
          severity: ErrorSeverity.error,
          error: e,
          stackTrace: st,
          context: 'SplashScreenPage.initState',
        );
        if (mounted) {
          context.router.replaceAll([PermissionRequestRoute()]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox.shrink(),
    );
  }
}
