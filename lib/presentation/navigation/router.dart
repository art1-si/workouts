import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:workouts/tools/logger/logger.dart';

class AppRouter {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter._() {
    final logOverviewNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'logOverview');
    final plansNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'plans');
    final exerciseSelectorNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'exerciseSelector');
    final settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

    _goRouter = GoRouter(
      initialLocation: Screens.splash.path,
      observers: [
        AnalyticsObserver(),
      ],
      routes: [
        GoRoute(
          name: Screens.splash.key,
          path: Screens.splash.path,
          builder: (context, state) => Screens.splash.widget(),
        ),
        GoRoute(
          name: Screens.login.key,
          path: Screens.login.path,
          builder: (context, state) => Screens.login.widget(),
        ),
        GoRoute(
          name: Screens.exerciseCreation.key,
          path: Screens.exerciseCreation.path,
          pageBuilder: (context, state) => MaterialPage(
            child: Screens.exerciseCreation.widget(params: state.extra as Map<String, dynamic>),
          ),
        ),
        GoRoute(
          name: Screens.logCreation.key,
          path: Screens.logCreation.path,
          pageBuilder: (context, state) => MaterialPage(
            child: Screens.logCreation.widget(params: state.extra as Map<String, dynamic>),
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return DashboardScreen(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: logOverviewNavigatorKey,
              routes: [
                GoRoute(
                  name: Screens.logsOverview.key,
                  path: Screens.logsOverview.path,
                  builder: (context, state) => Screens.logsOverview.widget(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: plansNavigatorKey,
              routes: [
                GoRoute(
                  name: Screens.plan.key,
                  path: Screens.plan.path,
                  builder: (context, state) => Screens.plan.widget(
                    params: state.extra == null ? {} : state.extra as Map<String, dynamic>,
                  ),
                  routes: [
                    GoRoute(
                      name: Screens.planCreation.key,
                      path: Screens.planCreation.path,
                      builder: (context, state) =>
                          Screens.planCreation.widget(params: state.extra as Map<String, dynamic>),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: exerciseSelectorNavigatorKey,
              routes: [
                GoRoute(
                  name: Screens.exerciseSelector.key,
                  path: Screens.exerciseSelector.path,
                  builder: (context, state) => Screens.exerciseSelector.widget(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: settingsNavigatorKey,
              routes: [
                GoRoute(
                  name: Screens.settings.key,
                  path: Screens.settings.path,
                  builder: (context, state) => Screens.settings.widget(),
                ),
              ],
            ),
          ],
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
