import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../navigation/navigation_routes.dart';
import 'bottom_navigation_bar/bottom_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final isModalLocation = NavigationRoute.fromLocation(location)?.isModal ?? false;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: isModalLocation
          ? null
          : WorkoutsBottomNavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            ),
    );
  }
}
