import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // add your routes here

        AutoRoute(
          path: '/auth',
          page: AuthRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'sign-in',
              page: LoginPageRoute.page,
            ),
            AutoRoute(
              path: 'sign-up',
              page: RegisterPageRoute.page,
            ),
            AutoRoute(
              path: "reg_continue",
              page: RegisterContinueRoute.page,
            )
          ],
        ),

        AutoRoute(
          path: '/',
          page: AppRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'userpage',
              page: UserPageRoute.page,
              children: [
                AutoRoute(
                  path: "home",
                  page: HomePageRoute.page,
                ),
                AutoRoute(
                  path: "profile",
                  page: ProfilePageRoute.page,
                ),
                AutoRoute(
                  path: "discover",
                  page: DiscoverPageRoute.page,
                ),
                AutoRoute(
                  path: "univhex",
                  page: UnivhexPageRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: "post-detail",
              page: PostDetailRoute.page,
            ),
            AutoRoute(path: "settings", page: SettingsRoute.page)
          ],
        )
      ];
}
