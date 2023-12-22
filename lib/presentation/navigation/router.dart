import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:workouts/presentation/screens/exercise_creation/execise_creation_modal.dart';
import 'package:workouts/presentation/screens/exercise_selector/exercise_selector_screen.dart';
import 'package:workouts/presentation/screens/log_creation/log_creation_screen.dart';
import 'package:workouts/presentation/screens/login/login_screen.dart';
import 'package:workouts/presentation/screens/logs_overview/logs_overview_screen.dart';
import 'package:workouts/presentation/screens/splash/splash_screen.dart';
import 'package:workouts/tools/logger/logger.dart';

class AppRouter {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter._() {
    final logOverviewNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'logOverview');
    final exerciseSelectorNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'exerciseSelector');

    _goRouter = GoRouter(
      initialLocation: Screens.splash.path,
      observers: [
        AnalyticsObserver(),
      ],
      routes: [
        GoRoute(
          name: Screens.splash.named,
          path: Screens.splash.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: Screens.login.named,
          path: Screens.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: Screens.exerciseCreation.named,
          path: Screens.exerciseCreation.path,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: ExerciseCreationModal(
              existingExercises: state.extra as List<Exercise>,
            ),
          ),
        ),
        GoRoute(
          name: Screens.logCreation.named,
          path: Screens.logCreation.path,
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
                  name: Screens.logsOverview.named,
                  path: Screens.logsOverview.path,
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
                    name: Screens.exerciseSelector.named,
                    path: Screens.exerciseSelector.path,
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
