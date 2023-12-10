import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/application/exercises/default_exercises_controller.dart';
import 'package:workouts/data/workout_logs/firebase_workout_logs_repository.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/data/workout_logs/workout_logs_repository.dart';

final workoutLogControllerProvider = StreamNotifierProvider<WorkoutLogController, List<WorkoutLog>>(
  () => WorkoutLogController(workoutLogsRepository: FirebaseWorkoutLogsRepository()),
);

class WorkoutLogController extends StreamNotifier<List<WorkoutLog>> {
  WorkoutLogController({required WorkoutLogsRepository workoutLogsRepository})
      : _workoutLogsRepository = workoutLogsRepository;

  final WorkoutLogsRepository _workoutLogsRepository;
  @override
  Stream<List<WorkoutLog>> build() {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;

    final exercisesAsyncValue = ref.watch(defaultExercisesControllerProvider);
    if (!exercisesAsyncValue.hasValue) {
      return Stream.value([]);
    }

    return _workoutLogsRepository.getWorkoutLogs(userId: userId);
  }

  Future<void> addLog(WorkoutLog log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.addWorkoutLog(userId: userId, workoutLog: log);
  }

  Future<void> updateLog(WorkoutLog log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.updateWorkoutLog(userId: userId, workoutLog: log);
  }

  Future<void> deleteLog(WorkoutLog log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.deleteWorkoutLog(userId: userId, workoutLog: log);
  }
}
