import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/screens/dashboard/bottom_navigation_bar/bottom_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final isModalLocation = Screens.fromLocation(location)?.isModal ?? false;

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
