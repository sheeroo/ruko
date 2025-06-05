import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/router/custom_route_transition.dart';
import 'package:ruko/core/router/router.gr.dart';

export 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      initial: true,
      page: AppRootRoute.page,
      children: [
        CustomRoute(
          path: '',
          page: SplashRouteRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(page: HomeRoute.page, transitionsBuilder: fadeTransition),
        CustomRoute(
          page: PermissionRequestRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: CategoryRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: CategoriesSwiperRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: CategoriesRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: ImageFullRoute.page,
          fullscreenDialog: true,
          opaque: false,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: VideoFullRoute.page,
          fullscreenDialog: true,
          opaque: false,
          transitionsBuilder: fadeTransition,
        ),
      ],
    ),
  ];
}
