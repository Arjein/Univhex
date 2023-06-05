import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Router/app_router.dart';

@RoutePage(name: 'UserPageRoute')
class UserPage extends HookWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = useState(0);
    return AutoTabsRouter(
      routes: [
        const HomePageRoute(),
        const DiscoverPageRoute(),
        ProfilePageRoute(user: CurrentUser.user),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: AnimatedBuilder(
            animation: tabsRouter,
            builder: (_, __) => ClipRRect(
              child: NavigationBar(
                indicatorColor: AppColors.bgColor,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                backgroundColor: AppColors.bgColor,
                height: CurrentUser.deviceHeight! * 0.06,
                selectedIndex: currentPage.value,
                onDestinationSelected: (value) {
                  switch (value) {
                    case 0:
                      tabsRouter.setActiveIndex(0);
                      currentPage.value = 0;
                      break;
                    case 1:
                      tabsRouter.setActiveIndex(1);
                      currentPage.value = 1;
                      break;
                    case 2:
                      tabsRouter.setActiveIndex(2);
                      currentPage.value = 2;
                      break;
                    default:
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(FluentIcons.home_32_regular),
                    selectedIcon: Icon(FluentIcons.home_32_filled),
                    label: 'Home',
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
            ),
          ),
          body: SizedBox(height: CurrentUser.deviceHeight! * 0.9, child: child),
        );
      },
    );
  }
}
