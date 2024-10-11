import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/presentation/features/exercise_creation/view/execise_creation_modal.dart';
import 'package:workouts/presentation/features/set_entry_creator/view/log_creation_screen.dart';
import 'package:workouts/presentation/features/splash/splash_screen.dart';
import 'navigation_routes.dart';

class AppRouter {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter._() {
    final logOverviewNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'logOverview');
    final exerciseSelectorNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'exerciseSelector');

    _goRouter = GoRouter(
      initialLocation: NavigationRoute.splash.path,
      observers: [
        AnalyticsObserver(),
      ],
      routes: [
        GoRoute(
          name: NavigationRoute.splash.named,
          path: NavigationRoute.splash.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: NavigationRoute.login.named,
          path: NavigationRoute.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: NavigationRoute.exerciseCreation.named,
          path: NavigationRoute.exerciseCreation.path,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: ExerciseCreationModal(
              existingExercises: state.extra as List<Exercise>,
            ),
          ),
        ),
        GoRoute(
          name: NavigationRoute.logCreation.named,
          path: NavigationRoute.logCreation.path,
          pageBuilder: (context, state) {
            final params = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: LogCreationScreen(
                exercises: params!['exercises'],
                indexOfSelectedExercise: params['indexOfSelectedExercise'],
              ),
            );
          },
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
                  name: NavigationRoute.logsOverview.named,
                  path: NavigationRoute.logsOverview.path,
                  builder: (context, state) => const LogsOverviewScreen(),
                ),
              ],
            ),
            // StatefulShellBranch(
            //   navigatorKey: plansNavigatorKey,
            //   routes: [
            //     GoRoute(
            //       name: Screens.plan.named,
            //       path: Screens.plan.path,
            //       builder: (context, state) => const PlanScreen(),
            //       routes: [
            //         GoRoute(
            //             name: Screens.planCreation.named,
            //             path: Screens.planCreation.path,
            //             builder: (context, state) => const PlanCreationScreen()),
            //       ],
            //     ),
            //   ],
            // ),
            StatefulShellBranch(
              navigatorKey: exerciseSelectorNavigatorKey,
              routes: [
                GoRoute(
                    name: NavigationRoute.exerciseSelector.named,
                    path: NavigationRoute.exerciseSelector.path,
                    builder: (context, state) => const ExerciseSelectorScreen()),
              ],
            ),
            // StatefulShellBranch(
            //   navigatorKey: settingsNavigatorKey,
            //   routes: [
            //     GoRoute(
            //         name: Screens.settings.named,
            //         path: Screens.settings.path,
            //         builder: (context, state) => const SettingsScreen()),
            //   ],
            // ),
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
