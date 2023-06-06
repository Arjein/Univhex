// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:univhex/Objects/app_user.dart' as _i16;
import 'package:univhex/Objects/univhex_post.dart' as _i15;
import 'package:univhex/Pages/Discover/discover_page.dart' as _i1;
import 'package:univhex/Pages/Home/home_screen.dart' as _i2;
import 'package:univhex/Pages/Home/post_detail.dart' as _i3;
import 'package:univhex/Pages/Login/login_screen.dart' as _i4;
import 'package:univhex/Pages/page_navigator.dart' as _i5;
import 'package:univhex/Pages/Profile/ProfileScreen.dart' as _i6;
import 'package:univhex/Pages/Register/Register.dart' as _i7;
import 'package:univhex/Pages/Register/RegisterContinue.dart' as _i8;
import 'package:univhex/Pages/Settings/settings.dart' as _i9;
import 'package:univhex/Pages/Univhex/univhex_screen.dart' as _i10;
import 'package:univhex/Router/empty_router_pages/app_router_empty.dart'
    as _i11;
import 'package:univhex/Router/empty_router_pages/auth_router_empty.dart'
    as _i12;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    DiscoverPageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DiscoverPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    PostDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PostDetailRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PostDetail(
          key: args.key,
          post: args.post,
          autoFocus: args.autoFocus,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>(
          orElse: () => const LoginPageRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    UserPageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.UserPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilePageRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ProfilePage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.Register(),
      );
    },
    RegisterContinueRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterContinueRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.RegisterContinue(
          key: args.key,
          name: args.name,
          surname: args.surname,
          email: args.email,
          password: args.password,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsPage(),
      );
    },
    UnivhexPageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UnivhexPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.AppRouterPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.AuthRouterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DiscoverPage]
class DiscoverPageRoute extends _i13.PageRouteInfo<void> {
  const DiscoverPageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          DiscoverPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverPageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomePageRoute extends _i13.PageRouteInfo<void> {
  const HomePageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PostDetail]
class PostDetailRoute extends _i13.PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    _i14.Key? key,
    required _i15.UnivhexPost post,
    required bool autoFocus,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          PostDetailRoute.name,
          args: PostDetailRouteArgs(
            key: key,
            post: post,
            autoFocus: autoFocus,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDetailRoute';

  static const _i13.PageInfo<PostDetailRouteArgs> page =
      _i13.PageInfo<PostDetailRouteArgs>(name);
}

class PostDetailRouteArgs {
  const PostDetailRouteArgs({
    this.key,
    required this.post,
    required this.autoFocus,
  });

  final _i14.Key? key;

  final _i15.UnivhexPost post;

  final bool autoFocus;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, post: $post, autoFocus: $autoFocus}';
  }
}

/// generated route for
/// [_i4.LoginScreen]
class LoginPageRoute extends _i13.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    _i14.Key? key,
    String? email,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          LoginPageRoute.name,
          args: LoginPageRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i13.PageInfo<LoginPageRouteArgs> page =
      _i13.PageInfo<LoginPageRouteArgs>(name);
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({
    this.key,
    this.email,
  });

  final _i14.Key? key;

  final String? email;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i5.UserPage]
class UserPageRoute extends _i13.PageRouteInfo<void> {
  const UserPageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UserPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserPageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfilePage]
class ProfilePageRoute extends _i13.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    _i14.Key? key,
    required _i16.AppUser? user,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ProfilePageRoute.name,
          args: ProfilePageRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfilePageRoute';

  static const _i13.PageInfo<ProfilePageRouteArgs> page =
      _i13.PageInfo<ProfilePageRouteArgs>(name);
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({
    this.key,
    required this.user,
  });

  final _i14.Key? key;

  final _i16.AppUser? user;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i7.Register]
class RegisterPageRoute extends _i13.PageRouteInfo<void> {
  const RegisterPageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RegisterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RegisterContinue]
class RegisterContinueRoute
    extends _i13.PageRouteInfo<RegisterContinueRouteArgs> {
  RegisterContinueRoute({
    _i14.Key? key,
    required String name,
    required String surname,
    required String email,
    required String password,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          RegisterContinueRoute.name,
          args: RegisterContinueRouteArgs(
            key: key,
            name: name,
            surname: surname,
            email: email,
            password: password,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterContinueRoute';

  static const _i13.PageInfo<RegisterContinueRouteArgs> page =
      _i13.PageInfo<RegisterContinueRouteArgs>(name);
}

class RegisterContinueRouteArgs {
  const RegisterContinueRouteArgs({
    this.key,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  final _i14.Key? key;

  final String name;

  final String surname;

  final String email;

  final String password;

  @override
  String toString() {
    return 'RegisterContinueRouteArgs{key: $key, name: $name, surname: $surname, email: $email, password: $password}';
  }
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UnivhexPage]
class UnivhexPageRoute extends _i13.PageRouteInfo<void> {
  const UnivhexPageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UnivhexPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnivhexPageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.AppRouterPage]
class AppRoute extends _i13.PageRouteInfo<void> {
  const AppRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.AuthRouterPage]
class AuthRoute extends _i13.PageRouteInfo<void> {
  const AuthRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
