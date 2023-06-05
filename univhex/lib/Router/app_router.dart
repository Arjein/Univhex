import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Pages/Home/post_detail.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Pages/Discover/discover_page.dart';
import 'package:univhex/Pages/Register/Register.dart';
import 'package:univhex/Pages/Register/RegisterContinue.dart';
import 'package:univhex/Pages/Settings/settings.dart';
import 'package:univhex/Pages/Univhex/univhex_screen.dart';
import 'package:univhex/Pages/page_navigator.dart';

import '../Pages/Home/home_screen.dart';
import '../Pages/Login/login_screen.dart';
import '../Pages/Profile/ProfileScreen.dart';
import 'empty_router_pages/app_router_empty.dart';
import 'empty_router_pages/auth_router_empty.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
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
          path: "/post-detail",
          page: PostDetailRoute.page,
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
            AutoRoute(path: "settings", page: SettingsRoute.page)
          ],
        )
      ];
}
