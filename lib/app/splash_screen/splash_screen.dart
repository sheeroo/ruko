import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/bootstrap.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/router/router.gr.dart';
import 'package:image_delete_demo/core/widgets/common/type_write_text.dart';
import 'package:permission_handler/permission_handler.dart';

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
    Bootstrap.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypeWriterText(
          center: true,
          onComplete: (_) async {
            await Bootstrap.instance.ensureInitialized;
            final status = await Permission.photos.status;
            if (status.isGranted) {
              if (!context.mounted) return;
              await context.read<GalleryAssetsCubit>().loadAssets();
              if (!context.mounted) return;
              context.router.replaceAll([HomeRoute()]);
            } else {
              if (!context.mounted) return;
              context.router.replaceAll([PermissionRequestRoute()]);
            }
          },
          texts: [
            AnimatableText(
              text: DateTime.now().build(
                (now) => "${now.dayMonth} ${now.getSeasonAndYear}",
              ),
              delay: 0.seconds,
              deleteDelay: 1.seconds,
            ),
          ],
        ),
      ),
    );
  }
}
