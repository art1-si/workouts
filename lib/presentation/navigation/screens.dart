import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/home/home_screen.dart';

/// Screens in the App.
enum Screen {
  home;

  // Key identifier of the Route. Needed for Beamer.
  String get key {
    return switch (this) {
      Screen.home => 'home',
    };
  }

  /// Returns a [Widget] for the corresponding `Screen`.
  Widget widget({Map<String, dynamic>? params}) {
    return switch (this) {
      Screen.home => const HomeScreen(),
    };
  }

  String get path {
    return switch (this) {
      Screen.home => '/home',
    };
  }
}
