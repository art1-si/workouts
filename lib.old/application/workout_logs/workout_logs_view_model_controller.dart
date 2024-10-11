import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../exercises/combine_exercises_controller.dart';
import '../selected_date/selected_date_controller.dart';
import 'models/workout_log_view_model.dart';
import 'workout_logs_controller.dart';
import '../../../lib/domain/entities/exercise.dart';
import '../../../lib/presentation/features/calendar/extension/date_time.dart';

final workoutLogsForSelectedDateProvider = AsyncNotifierProvider<WorkoutLogsForDateNotifier, List<WorkoutLogViewModel>>(
  WorkoutLogsForDateNotifier.new,
);

class WorkoutLogsForDateNotifier extends AsyncNotifier<List<WorkoutLogViewModel>> {
  List<WorkoutLogViewModel>? _previousState;

  @override
  FutureOr<List<WorkoutLogViewModel>> build() async {
    if (_previousState != null) {
      state = AsyncData(_previousState!);
    }
    final selectedDate = ref.watch(selectedDateProvider);
    final logs = await ref.watch(workoutLogControllerProvider.future);
    final exercises = await ref.watch(combineExercisesControllerProvider.future);

    final logsForDate = logs.where((element) => element.dateCreated.isEqual(selectedDate)).toList();

    final groupedLogs = groupBy(logsForDate, (log) => log.exerciseID);

    final workoutLogs = groupedLogs.keys.map((id) {
      final exercise = exercises.firstWhere(
        (element) => element.id == id,
        orElse: Exercise.unknown,
      );
      return WorkoutLogViewModel(
        exercise: exercise,
        workoutLog: groupedLogs[id]!,
      );
    }).toList();
    _previousState = workoutLogs;
    return workoutLogs;
  }
}
