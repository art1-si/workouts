import 'package:collection/collection.dart';

/// Screens in the App.
enum NavigationRoute {
  splash(named: 'splash', path: '/splash'),
  login(named: 'login', path: '/login'),
  logsOverview(named: 'logsOverview', path: '/logsOverview'),
  plan(named: 'plan', path: '/plan'),
  exerciseSelector(named: 'exerciseSelector', path: '/exerciseSelector'),
  settings(named: 'settings', path: '/settings'),
  exerciseCreation(named: 'exerciseCreation', path: '/exerciseCreation'),
  logCreation(named: 'logCreation', path: '/logCreation'),
  planCreation(named: 'planCreation', path: 'planCreation');

  const NavigationRoute({
    required this.named,
    required this.path,
  });

  final String named;
  final String path;

  static NavigationRoute? fromLocation(String location) {
    final rootLevelLocation = NavigationRoute.values.firstWhereOrNull((screen) => screen.path == location);
    if (rootLevelLocation != null) {
      return rootLevelLocation;
    }

    return null;
  }

  bool get isModal {
    switch (this) {
      case NavigationRoute.logCreation:
      case NavigationRoute.exerciseCreation:
        return true;
      default:
        return false;
    }
  }
}
