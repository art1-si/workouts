import 'dart:developer' as developer;
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:workouts/configuration/build_configuration.dart';

import 'logger_level.dart';

/// Class that logs to the console.
class Logger {
  /// Call this in `main` to set up global error recording behaviour.
  static void initialize() {
    if (_reportToCrashlytics) {
      FlutterError.onError = _crashlytics.recordFlutterFatalError;
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  /// The minimum `LogLevel` that needs to be logged by the app.
  /// Order: debug < info < warning < error.
  /// Error is (and should) always be logged.
  static LogLevel get _minimumLogLevel {
    switch (AppConfiguration.buildConfiguration) {
      case BuildConfiguration.dev:
        return LogLevel.debug;
      case BuildConfiguration.internal:
      case BuildConfiguration.uat:
        return LogLevel.info;
      default:
        return LogLevel.warning;
    }
  }

  static bool get _reportToCrashlytics => !AppConfiguration.isDev;

  static final _crashlytics = FirebaseCrashlytics.instance;

  /// Integer representation of the log level.
  static int _logLevelIntegerRepresentation(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }

  /// Symbol representation of the log level.
  static String _logLevelSymbol(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🟢';
      case LogLevel.info:
        return '🔵';
      case LogLevel.warning:
        return '🟡';
      case LogLevel.error:
        return '🔴';
    }
  }

  /// Get the full logging message.
  static String _fullLogMessage(String message, {required LogLevel level}) {
    return '${_logLevelSymbol(level)} $message';
  }

  /// Emit a debug event.
  static void debug(
    String message, {
    StackTrace? stackTrace,
  }) {
    if (_shouldLog(LogLevel.debug)) {
      /// Log.
      developer.log(
        _fullLogMessage(message, level: LogLevel.debug),
        level: _logLevelIntegerRepresentation(LogLevel.debug),
        stackTrace: stackTrace,
      );

      if (_reportToCrashlytics) {
        _crashlytics.recordError(message, stackTrace);
      }
    }
  }

  /// Emit an info event.
  static void info(
    String message, {
    StackTrace? stackTrace,
  }) {
    if (_shouldLog(LogLevel.info)) {
      /// Log.
      developer.log(
        _fullLogMessage(message, level: LogLevel.info),
        level: _logLevelIntegerRepresentation(LogLevel.info),
        stackTrace: stackTrace,
      );
    }
  }

  /// Emit a warning event.
  static void warning(
    String message, {
    StackTrace? stackTrace,
  }) {
    if (_shouldLog(LogLevel.warning)) {
      /// Log.
      developer.log(
        _fullLogMessage(message, level: LogLevel.warning),
        level: _logLevelIntegerRepresentation(LogLevel.warning),
        stackTrace: stackTrace,
      );

      if (_reportToCrashlytics) {
        _crashlytics.recordError(message, stackTrace);
      }
    }
  }

  /// Emit an error event.
  static void error(
    String message,
    StackTrace stackTrace,
  ) {
    if (_shouldLog(LogLevel.error)) {
      /// Log.
      developer.log(
        _fullLogMessage(message, level: LogLevel.error),
        level: _logLevelIntegerRepresentation(LogLevel.error),
        stackTrace: stackTrace,
      );

      if (_reportToCrashlytics) {
        _crashlytics.recordError(message, stackTrace);
      }
    }
  }

  /// Whether or not a `LogLevel` needs to be logged.
  static bool _shouldLog(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return _minimumLogLevel == LogLevel.debug;
      case LogLevel.info:
        return [LogLevel.debug, LogLevel.info].contains(_minimumLogLevel);
      case LogLevel.warning:
        return [LogLevel.debug, LogLevel.info, LogLevel.warning].contains(_minimumLogLevel);
      case LogLevel.error:
        return true;
    }
  }

  /// Sets a user identifier by which error logs in Crashlytics can be associated to a user.
  static Future<void> setErrorLogUserIdentifier(String userIdentifier) async {
    if (_reportToCrashlytics) {
      return _crashlytics.setUserIdentifier(userIdentifier);
    }
  }

  /// Sets custom attributes that can be read on an error log in Crashlytics.
  static Future<void> setErrorLogAttribute({required String key, required Object value}) async {
    if (_reportToCrashlytics) {
      return _crashlytics.setCustomKey(key, value);
    }
  }
}
