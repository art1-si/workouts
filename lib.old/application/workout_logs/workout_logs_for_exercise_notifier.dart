import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/workout_log_view_model.dart';
import 'workout_logs_controller.dart';
import '../../../lib/domain/entities/exercise.dart';

final workoutLogsForExerciseProvider =
    NotifierProvider.family<WorkoutLogsForExerciseNotifier, AsyncValue<WorkoutLogViewModel>, Exercise>(
  WorkoutLogsForExerciseNotifier.new,
);

class WorkoutLogsForExerciseNotifier extends FamilyNotifier<AsyncValue<WorkoutLogViewModel>, Exercise> {
  WorkoutLogViewModel? _previousState;

  @override
  AsyncValue<WorkoutLogViewModel> build(Exercise arg) {
    final logs = ref.watch(workoutLogControllerProvider);

    if (logs.isLoading && _previousState == null) {
      return const AsyncLoading();
    }
    if (logs.hasValue) {
      final logsForExercise = logs.value!.where((element) => element.exerciseID == arg.id).toList();
      final value = WorkoutLogViewModel(exercise: arg, workoutLog: logsForExercise);
      _previousState = value;
      return AsyncData(value);
    }

    return AsyncData(_previousState!);
  }
}
