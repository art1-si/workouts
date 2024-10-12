import 'package:flutter/foundation.dart';

import 'package:workouts/domain/entities/exercise_series.dart';

/// Represents a workout session within a date with multiple exercises.
class WorkoutSession {
  WorkoutSession({required this.date, required this.exerciseSeries});

  final DateTime date;
  final List<ExerciseSeries> exerciseSeries;

  @override
  String toString() => 'WorkoutSession(date: $date, exerciseSeries: $exerciseSeries)';

  @override
  bool operator ==(covariant WorkoutSession other) {
    if (identical(this, other)) return true;

    return other.date == date && listEquals(other.exerciseSeries, exerciseSeries);
  }

  @override
  int get hashCode => date.hashCode ^ exerciseSeries.hashCode;
}
