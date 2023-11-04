import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/exercise_creation/execise_creation_screen.dart';
import 'package:workouts/presentation/screens/exercise_selector/exercise_selector_screen.dart';
import 'package:workouts/presentation/screens/home/home_screen.dart';
import 'package:workouts/presentation/screens/log_creation/log_creation_screen.dart';
import 'package:workouts/presentation/screens/plan/plan_screen.dart';
import 'package:workouts/presentation/screens/plan_creation/plan_creation_screen.dart';
import 'package:workouts/presentation/screens/settings/settings_screen.dart';

/// Screens in the App.
enum Screen {
  logs,
  plan,
  exerciseSelector,
  settings,
  exerciseCreation,
  logCreation,
  planCreation;

  // Key identifier of the Route. Needed for Beamer.
  String get key {
    return switch (this) {
      Screen.logs => 'logs',
      Screen.plan => 'plan',
      Screen.exerciseSelector => 'exerciseSelector',
      Screen.settings => 'settings',
      Screen.exerciseCreation => 'exerciseCreation',
      Screen.logCreation => ' logCreation',
      Screen.planCreation => 'planCreation',
    };
  }

  /// Returns a [Widget] for the corresponding `Screen`.
  Widget widget({Map<String, dynamic>? params}) {
    return switch (this) {
      Screen.logs => const LogsScreen(),
      Screen.plan => const PlanScreen(),
      Screen.exerciseSelector => const ExerciseSelectorScreen(),
      Screen.settings => const SettingsScreen(),
      Screen.exerciseCreation => const ExerciseCreationScreen(),
      Screen.logCreation => const LogCreationScreen(),
      Screen.planCreation => const PlanCreationScreen(),
    };
  }

  String get path {
    return switch (this) {
      Screen.logs => '/home',
      Screen.plan => '/plan',
      Screen.exerciseSelector => '/exerciseSelector',
      Screen.settings => '/settings',
      Screen.exerciseCreation => '/exerciseCreation',
      Screen.logCreation => '/logCreation',
      Screen.planCreation => '/planCreation',
    };
  }
}
