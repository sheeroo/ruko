import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/router/router.gr.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

@RoutePage()
class PermissionRequestPage extends StatelessWidget {
  const PermissionRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StyledButton.filled(
          leading: Icon(Pixel.image, color: Colors.white, size: 30),
          title: 'give gallery access',
          onPressed: () async {
            final state = await PhotoManager.requestPermissionExtend();
            if (state.hasAccess) {
              if (!context.mounted) return;
              await context.read<GalleryAssetsCubit>().loadAssets();
              if (!context.mounted) return;
              context.router.replaceAll([HomeRoute()]);
            }
          },
        ).p(all: 12),
      ),
    );
  }
}
