import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Router/app_router.gr.dart';

@RoutePage(name: 'UserPageRoute')
class UserPage extends HookWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = useState(0);
    return AutoTabsRouter(
      routes: [
        const HomePageRoute(),
        const UnivhexPageRoute(),
        const DiscoverPageRoute(),
        ProfilePageRoute(user: CurrentUser.user),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            indicatorColor: AppColors.bgColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            backgroundColor: AppColors.bgColor,
            selectedIndex: currentPage.value,
            onDestinationSelected: (value) {
              tabsRouter.setActiveIndex(value);
              currentPage.value = value;
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(FluentIcons.home_32_regular),
                selectedIcon: Icon(FluentIcons.home_32_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.hexagon_outlined),
                selectedIcon: Icon(Icons.hexagon_rounded),
                label: 'Univhex',
              ),
              NavigationDestination(
                icon: Icon(FluentIcons.compass_northwest_28_regular),
                selectedIcon: Icon(FluentIcons.compass_northwest_28_filled),
                label: 'Discover',
              ),
              NavigationDestination(
                icon: Icon(FluentIcons.person_48_regular),
                selectedIcon: Icon(FluentIcons.person_48_filled),
                label: 'Profile',
              ),
            ],
          ),
          body: child,
        );
      },
    );
  }
}
