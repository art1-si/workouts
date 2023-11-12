import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/exercise_creation/execise_creation_screen.dart';
import 'package:workouts/presentation/screens/exercise_selector/exercise_selector_screen.dart';
import 'package:workouts/presentation/screens/log_creation/log_creation_screen.dart';
import 'package:workouts/presentation/screens/login/login_screen.dart';
import 'package:workouts/presentation/screens/logs_overview/logs_overview_screen.dart';
import 'package:workouts/presentation/screens/plan/plan_screen.dart';
import 'package:workouts/presentation/screens/plan_creation/plan_creation_screen.dart';
import 'package:workouts/presentation/screens/settings/settings_screen.dart';
import 'package:workouts/presentation/screens/splash/splash_screen.dart';

/// Screens in the App.
enum Screens {
  splash,
  login,
  logsOverview,
  plan,
  exerciseSelector,
  settings,
  exerciseCreation,
  logCreation,
  planCreation;

  // Key identifier of the Route. Needed for Beamer.
  String get key {
    return switch (this) {
      Screens.splash => 'splash',
      Screens.login => 'login',
      Screens.logsOverview => 'logs',
      Screens.plan => 'plan',
      Screens.exerciseSelector => 'exerciseSelector',
      Screens.settings => 'settings',
      Screens.exerciseCreation => 'exerciseCreation',
      Screens.logCreation => ' logCreation',
      Screens.planCreation => 'planCreation',
    };
  }

  /// Returns a [Widget] for the corresponding `Screen`.
  Widget widget({Map<String, dynamic>? params}) {
    return switch (this) {
      Screens.splash => const SplashScreen(),
      Screens.login => const LoginScreen(),
      Screens.logsOverview => const LogsOverviewScreen(),
      Screens.plan => const PlanScreen(),
      Screens.exerciseSelector => const ExerciseSelectorScreen(),
      Screens.settings => const SettingsScreen(),
      Screens.exerciseCreation => const ExerciseCreationScreen(),
      Screens.logCreation => LogCreationScreen(
          exercises: params!['exercises'],
          indexOfSelectedExercise: params['indexOfSelectedExercise'],
        ),
      Screens.planCreation => const PlanCreationScreen(),
    };
  }

  String get path {
    return switch (this) {
      Screens.splash => '/splash',
      Screens.login => '/login',
      Screens.logsOverview => '/logsOverview',
      Screens.plan => '/plan',
      Screens.exerciseSelector => '/exerciseSelector',
      Screens.settings => '/settings',
      Screens.exerciseCreation => '/exerciseCreation',
      Screens.logCreation => '/logCreation',
      Screens.planCreation => 'planCreation',
    };
  }
}
