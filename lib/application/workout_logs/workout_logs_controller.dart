import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/data/workout_logs/firebase_workout_logs_repository.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/data/workout_logs/workout_logs_repository.dart';

final workoutLogProvider = StreamNotifierProvider<WorkoutLogController, List<WorkoutLog>>(
  () => WorkoutLogController(workoutLogsRepository: FirebaseWorkoutLogsRepository()),
);

class WorkoutLogController extends StreamNotifier<List<WorkoutLog>> {
  WorkoutLogController({required WorkoutLogsRepository workoutLogsRepository})
      : _workoutLogsRepository = workoutLogsRepository;

  final WorkoutLogsRepository _workoutLogsRepository;
  @override
  Stream<List<WorkoutLog>> build() {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;

    return _workoutLogsRepository.getWorkoutLogs(userId: userId);
  }
}
