import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/limiters/throttler.dart';
import 'package:image_delete_demo/cubit/image_delete_cubit.dart';

@RoutePage()
class AppRootPage extends StatelessWidget {
  AppRootPage({super.key});
  final throttler = Throttler(3.seconds);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GalleryAssetsCubit()),
        BlocProvider(create: (context) => ImageDeleteCubit()),
      ],
      child: const AutoRouter(),
    );
  }
}
