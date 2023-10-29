import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/tools/logger/logger.dart';

class AppRouter {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter._() {
    _goRouter = GoRouter(
      initialLocation: Screen.home.path,
      observers: [
        AnalyticsObserver(),
      ],
      routes: [
        GoRoute(
          name: Screen.home.key,
          path: Screen.home.path,
          builder: (context, state) => Screen.home.widget(),
        ),
      ],
    );
  }

  // The Main Navigation Delegate.
  late final GoRouter _goRouter;

  static final AppRouter instance = AppRouter._();

  /// The (Main) Navigation Delegate for the App.
  static GoRouter router = instance._goRouter;
}

class AnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      Logger.setErrorLogAttribute(key: 'route', value: route.settings.name!);
    }
    if (previousRoute?.settings.name != null) {
      Logger.setErrorLogAttribute(key: 'previousRoute', value: previousRoute!.settings.name!);
    }
    //TODO:Implement analytics
    // analytics.setCurrentScreen(route.settings.name ?? '');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute?.settings.name != null) {
      Logger.setErrorLogAttribute(key: 'route', value: newRoute!.settings.name!);
    }
    if (oldRoute?.settings.name != null) {
      Logger.setErrorLogAttribute(key: 'previousRoute', value: oldRoute!.settings.name!);
    }
    //TODO:Implement analytics
  }
}
