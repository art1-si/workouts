import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/application/exercises/default_exercises_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/data/workout_logs/firebase_workout_logs_repository.dart';
import 'package:workouts/data/workout_logs/workout_logs_repository.dart';

final workoutLogProvider = StreamNotifierProvider<WorkoutLogController, List<WorkoutLogViewModel>>(
  () => WorkoutLogController(workoutLogsRepository: FirebaseWorkoutLogsRepository()),
);

class WorkoutLogController extends StreamNotifier<List<WorkoutLogViewModel>> {
  WorkoutLogController({required WorkoutLogsRepository workoutLogsRepository})
      : _workoutLogsRepository = workoutLogsRepository;

  final WorkoutLogsRepository _workoutLogsRepository;
  @override
  Stream<List<WorkoutLogViewModel>> build() {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;

    final exercisesAsyncValue = ref.watch(defaultExercisesControllerProvider);
    if (!exercisesAsyncValue.hasValue) {
      return Stream.value([]);
    }

    final logs = _workoutLogsRepository.getWorkoutLogs(userId: userId);

    final exercises = exercisesAsyncValue.value!;

    return logs.map((event) {
      return event.map(
        (log) {
          try {
            final exercise = exercises.firstWhere(
              (element) => element.id == log.exerciseID,
            );

            return WorkoutLogViewModel(
              workoutLog: log,
              exercise: exercise,
            );
          } catch (e) {
            return WorkoutLogViewModel(
              workoutLog: log,
              exercise: Exercise.unknown(),
            );
          }
        },
      ).toList();
    });
  }
}
