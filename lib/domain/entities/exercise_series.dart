import 'package:flutter/foundation.dart';

import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/entities/set_entry.dart';
import 'package:workouts/domain/extensions/date_time_extensions.dart';

/// Represents a series of sets for a specific exercise within a date.
class ExerciseSeries {
  ExerciseSeries({
    required this.exercise,
    required this.setEntries,
  }) {
    assert(setEntries.isNotEmpty, 'setEntries cannot be empty');
    assert(setEntries.every((element) => element.exerciseId == exercise.id),
        'setEntries must all be for the same exercise');
    assert(setEntries.every((element) => element.dateCreated.atMidnight == setEntries.first.dateCreated.atMidnight),
        'setEntries must all be for the same date');
    date = setEntries.first.dateCreated;
  }

  final Exercise exercise;
  late final DateTime date;
  final List<SetEntry> setEntries;

  @override
  String toString() => 'ExerciseSeries(exercise: $exercise, date: $date, setEntries: $setEntries)';

  @override
  bool operator ==(covariant ExerciseSeries other) {
    if (identical(this, other)) return true;

    return other.exercise == exercise && other.date == date && listEquals(other.setEntries, setEntries);
  }

  @override
  int get hashCode => exercise.hashCode ^ date.hashCode ^ setEntries.hashCode;
}
