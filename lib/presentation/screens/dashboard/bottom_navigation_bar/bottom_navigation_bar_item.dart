import 'package:flutter/material.dart';

class WorkoutsBottomNavigationBarItem extends NavigationDestination {
  factory WorkoutsBottomNavigationBarItem.logOverview() => const WorkoutsBottomNavigationBarItem._(
        label: 'LOG',
        icon: Icon(Icons.dashboard_outlined, color: Colors.white),
        selectedIcon: Icon(Icons.dashboard, color: Colors.white),
      );

  factory WorkoutsBottomNavigationBarItem.plans() => const WorkoutsBottomNavigationBarItem._(
        label: 'PLAN',
        icon: Icon(Icons.view_agenda_outlined, color: Colors.white),
        selectedIcon: Icon(Icons.view_agenda, color: Colors.white),
      );

  factory WorkoutsBottomNavigationBarItem.exercises() => const WorkoutsBottomNavigationBarItem._(
        label: 'EXERCISES',
        icon: Icon(Icons.format_align_justify, color: Colors.white),
        selectedIcon: Icon(Icons.format_align_justify, color: Colors.white),
      );

  factory WorkoutsBottomNavigationBarItem.settings() => const WorkoutsBottomNavigationBarItem._(
        label: 'SETTINGS',
        icon: Icon(Icons.settings, color: Colors.white),
        selectedIcon: Icon(Icons.settings, color: Colors.white),
      );

  const WorkoutsBottomNavigationBarItem._({
    required super.label,
    required super.icon,
    required super.selectedIcon,
  });
}
