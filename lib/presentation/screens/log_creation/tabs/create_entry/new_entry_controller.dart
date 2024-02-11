import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/selected_date/selected_date_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/global/utils/uuid_mixin.dart';
import 'package:workouts/tools/logger/logger.dart';

final newEntryMediatorProvider = Provider.autoDispose.family<NewEntryMediator, WorkoutLogViewModel>((ref, log) {
  final selectedDate = ref.watch(selectedDateProvider);
  return NewEntryMediator(log, selectedDate);
});

class NewEntryMediator with UUIDGenerator {
  NewEntryMediator(WorkoutLogViewModel logs, this._selectedDate) : _exercise = logs.exercise {
    _latestEntry = logs.workoutLog.lastOrNull;
    _weight = _latestEntry?.weight ?? 40.0;
    _reps = _latestEntry?.reps ?? 12;
    _rpe = _latestEntry?.exerciseRPE ?? 10;
  }
  final Exercise _exercise;
  final DateTime _selectedDate;

  late double _weight;
  late int _reps;
  late int _rpe;

  double get weight => _weight;
  int get reps => _reps;
  int get rpe => _rpe;

  final editableWorkoutLog = ValueNotifier<WorkoutLog?>(null);
  WorkoutLog? _latestEntry;

  void toggleEditMode(WorkoutLog workoutLog) {
    if (editableWorkoutLog.value == workoutLog) {
      _updateValuesWith(_latestEntry!);
      editableWorkoutLog.value = null;
      return;
    }
    _updateValuesWith(workoutLog);
    editableWorkoutLog.value = workoutLog;
  }

  void _updateValuesWith(WorkoutLog workoutLog) {
    _weight = workoutLog.weight;
    _reps = workoutLog.reps;
    _rpe = workoutLog.exerciseRPE;
  }

  WorkoutLog get workoutLog => WorkoutLog(
        id: editableWorkoutLog.value?.id ?? dateBaseUUID,
        exerciseRPE: _rpe,
        weight: _weight,
        reps: _reps,
        exerciseID: _exercise.id,
        exerciseType: _exercise.exerciseType,
        dateCreated: editableWorkoutLog.value?.dateCreated ?? _selectedDate,
      );

  void setWeightWithNewValue(double newValue) {
    Logger.debug('New weight: $newValue');
    _weight = newValue;
  }

  void setRepsWithNewValue(int newValue) {
    _reps = newValue;
  }

  void setRPEWithNewValue(int newValue) {
    _rpe = newValue;
  }
}
