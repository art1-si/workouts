import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/data/exercises/model/exercise.dart';

final workoutLogsForExercisesProvider =
    StreamNotifierProvider.family<WorkoutLogsForExercisesController, List<WorkoutLogViewModel>, Exercise>(
  WorkoutLogsForExercisesController.new,
);

class WorkoutLogsForExercisesController extends FamilyStreamNotifier<List<WorkoutLogViewModel>, Exercise> {
  @override
  Stream<List<WorkoutLogViewModel>> build(Exercise exercise) async* {
    final logs = await ref.watch(workoutLogProvider.future);

    yield logs.where((element) => element.exercise.id == exercise.id).toList();
  }
}
