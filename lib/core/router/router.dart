import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/router/custom_route_transition.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/modals/modal_sheet_builder.dart';

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
          page: GenericSwiperRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: PermissionRequestRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: AlbumsRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: OldAssetsFirstRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: ShuffledAssetsRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: LocationsRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: MonthsRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: VideosOnlyRoute.page,
          transitionsBuilder: fadeTransition,
        ),
        CustomRoute(
          page: CategoriesBottomSheetRoute.page,
          transitionsBuilder: fadeTransition,
          customRouteBuilder: modalSheetBuilder,
        ),
        CustomRoute(
          page: FSAssetRoute.page,
          fullscreenDialog: true,
          opaque: false,
          transitionsBuilder: fadeTransition,
        ),
      ],
    ),
  ];
}
