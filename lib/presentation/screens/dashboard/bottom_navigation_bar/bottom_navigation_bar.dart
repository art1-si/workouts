import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/dashboard/bottom_navigation_bar/bottom_navigation_bar_item.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

/// The different Navigation Bars in the PMT app.
class WorkoutsBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const WorkoutsBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              fontSize: 10,
              letterSpacing: 1.2,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        elevation: 0,
        backgroundColor: AppColors.primaryShades.shade90,
        indicatorColor: AppColors.primaryShades.shade80,
        destinations: [
          WorkoutsBottomNavigationBarItem.logOverview(),
          // WorkoutsBottomNavigationBarItem.plans(),
          WorkoutsBottomNavigationBarItem.exercises(),
          //  WorkoutsBottomNavigationBarItem.settings(),
        ],
        onDestinationSelected: onTap,
      ),
    );
  }
}
