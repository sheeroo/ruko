import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/app/gallery/cubit/asset_paths_cubit.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/button.dart';

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
            final permissionState =
                await PhotoManager.requestPermissionExtend();
            if (permissionState.hasAccess) {
              if (!context.mounted) return;
              await context.read<AssetPathsCubit>().loadPaths();
              if (!context.mounted) return;
              context.router.replaceAll([HomeRoute()]);
            }
          },
        ).p(all: 12),
      ),
    );
  }
}
