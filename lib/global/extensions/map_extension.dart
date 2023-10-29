import 'package:workouts/tools/logger/logger.dart';

extension Caster on Map<String, dynamic> {
  T castAs<T>(String key) {
    try {
      return this[key] as T;
    } catch (e, st) {
      Logger.error('Error on casting key: $key. Error: $e', st);
      rethrow;
    }
  }

  T? tryCastAs<T>(String key) {
    try {
      return this[key] as T;
    } catch (e, _) {
      return null;
    }
  }
}
