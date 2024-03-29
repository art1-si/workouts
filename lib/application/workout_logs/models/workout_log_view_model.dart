// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';

class WorkoutLogViewModel {
  WorkoutLogViewModel({
    required this.exercise,
    required this.workoutLog,
  });
  Exercise exercise;
  List<WorkoutLog> workoutLog;

  WorkoutLogViewModel copyWith({
    Exercise? exercise,
    List<WorkoutLog>? workoutLog,
  }) {
    return WorkoutLogViewModel(
      exercise: exercise ?? this.exercise,
      workoutLog: workoutLog ?? this.workoutLog,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exercise': exercise.toMap(),
      'workoutLog': workoutLog.map((x) => x.toMap()).toList(),
    };
  }

  factory WorkoutLogViewModel.fromMap(Map<String, dynamic> map) {
    return WorkoutLogViewModel(
      exercise: Exercise.fromMap(map['exercise'] as Map<String, dynamic>),
      workoutLog: List<WorkoutLog>.from(
        (map['workoutLog'] as List<int>).map<WorkoutLog>(
          (x) => WorkoutLog.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutLogViewModel.fromJson(String source) =>
      WorkoutLogViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WorkoutLogViewModel(exercise: $exercise, workoutLog: $workoutLog)';

  @override
  bool operator ==(covariant WorkoutLogViewModel other) {
    if (identical(this, other)) return true;

    return other.exercise == exercise && listEquals(other.workoutLog, workoutLog);
  }

  @override
  int get hashCode => exercise.hashCode ^ workoutLog.hashCode;
}
