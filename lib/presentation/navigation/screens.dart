import 'package:collection/collection.dart';

/// Screens in the App.
enum Screens {
  splash(named: 'splash', path: '/splash'),
  login(named: 'login', path: '/login'),
  logsOverview(named: 'logsOverview', path: '/logsOverview'),
  plan(named: 'plan', path: '/plan'),
  exerciseSelector(named: 'exerciseSelector', path: '/exerciseSelector'),
  settings(named: 'settings', path: '/settings'),
  exerciseCreation(named: 'exerciseCreation', path: '/exerciseCreation'),
  logCreation(named: 'logCreation', path: '/logCreation'),
  planCreation(named: 'planCreation', path: 'planCreation');

  const Screens({
    required this.named,
    required this.path,
  });

  final String named;
  final String path;

  static Screens? fromLocation(String location) {
    final rootLevelLocation = Screens.values.firstWhereOrNull((screen) => screen.path == location);
    if (rootLevelLocation != null) {
      return rootLevelLocation;
    }

    return null;
  }

  bool get isModal {
    switch (this) {
      case Screens.logCreation:
      case Screens.exerciseCreation:
        return true;
      default:
        return false;
    }
  }
}
