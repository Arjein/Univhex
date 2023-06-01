// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    PostDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PostDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostDetail(
          key: args.key,
          post: args.post,
        ),
      );
    },
    HomePageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    DiscoverPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiscoverPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Register(),
      );
    },
    RegisterContinueRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterContinueRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterContinue(
          key: args.key,
          name: args.name,
          surname: args.surname,
          email: args.email,
          password: args.password,
        ),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfilePage(
          key: args.key,
          currentUser: args.currentUser,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>(
          orElse: () => const LoginPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    UserPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthRouterPage(),
      );
    },
    AppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppRouterPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [PostDetail]
class PostDetailRoute extends PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    Key? key,
    required UnivhexPost post,
    List<PageRouteInfo>? children,
  }) : super(
          PostDetailRoute.name,
          args: PostDetailRouteArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDetailRoute';

  static const PageInfo<PostDetailRouteArgs> page =
      PageInfo<PostDetailRouteArgs>(name);
}

class PostDetailRouteArgs {
  const PostDetailRouteArgs({
    this.key,
    required this.post,
  });

  final Key? key;

  final UnivhexPost post;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<void> {
  const HomePageRoute({List<PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiscoverPage]
class DiscoverPageRoute extends PageRouteInfo<void> {
  const DiscoverPageRoute({List<PageRouteInfo>? children})
      : super(
          DiscoverPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Register]
class RegisterPageRoute extends PageRouteInfo<void> {
  const RegisterPageRoute({List<PageRouteInfo>? children})
      : super(
          RegisterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterContinue]
class RegisterContinueRoute extends PageRouteInfo<RegisterContinueRouteArgs> {
  RegisterContinueRoute({
    Key? key,
    required String name,
    required String surname,
    required String email,
    required String password,
    List<PageRouteInfo>? children,
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

  static const PageInfo<RegisterContinueRouteArgs> page =
      PageInfo<RegisterContinueRouteArgs>(name);
}

class RegisterContinueRouteArgs {
  const RegisterContinueRouteArgs({
    this.key,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  final Key? key;

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
/// [ProfilePage]
class ProfilePageRoute extends PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    Key? key,
    required AppUser? currentUser,
    List<PageRouteInfo>? children,
  }) : super(
          ProfilePageRoute.name,
          args: ProfilePageRouteArgs(
            key: key,
            currentUser: currentUser,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfilePageRoute';

  static const PageInfo<ProfilePageRouteArgs> page =
      PageInfo<ProfilePageRouteArgs>(name);
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({
    this.key,
    required this.currentUser,
  });

  final Key? key;

  final AppUser? currentUser;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, currentUser: $currentUser}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginPageRoute extends PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    Key? key,
    String? email,
    List<PageRouteInfo>? children,
  }) : super(
          LoginPageRoute.name,
          args: LoginPageRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const PageInfo<LoginPageRouteArgs> page =
      PageInfo<LoginPageRouteArgs>(name);
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({
    this.key,
    this.email,
  });

  final Key? key;

  final String? email;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [UserPage]
class UserPageRoute extends PageRouteInfo<void> {
  const UserPageRoute({List<PageRouteInfo>? children})
      : super(
          UserPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthRouterPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppRouterPage]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
