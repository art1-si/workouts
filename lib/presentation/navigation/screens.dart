import 'package:flutter/material.dart';

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
      Screen.home => throw UnimplementedError(),
    };
  }

  String get path {
    return switch (this) {
      Screen.home => 'newsItem/:id',
    };
  }
}
