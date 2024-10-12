import 'package:flutter/foundation.dart';

import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/entities/set_entry.dart';

/// Represents a series of sets for a specific exercise.
class ExerciseSeries {
  ExerciseSeries({
    required this.exercise,
    required this.setEntries,
  });

  final Exercise exercise;
  final List<SetEntry> setEntries;

  @override
  String toString() => 'ExerciseSeries(exercise: $exercise, setEntries: $setEntries)';

  @override
  bool operator ==(covariant ExerciseSeries other) {
    if (identical(this, other)) return true;

    return other.exercise == exercise && listEquals(other.setEntries, setEntries);
  }

  @override
  int get hashCode => exercise.hashCode ^ setEntries.hashCode;
}
