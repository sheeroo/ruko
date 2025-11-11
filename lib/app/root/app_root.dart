import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruko/app/gallery/cubit/asset_paths_cubit.dart';
import 'package:ruko/app/gallery/cubit/gallery_assets_cubit.dart';
import 'package:ruko/core/limiters/throttler.dart';

@RoutePage()
class AppRootPage extends StatelessWidget {
  AppRootPage({super.key});
  final throttler = Throttler(3.seconds);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GalleryAssetsCubit()),
        BlocProvider(create: (context) => AssetPathsCubit()),
      ],
      child: const AutoRouter(),
    );
  }
}
