import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/authentication_controller.dart';
import '../exercises/default_exercises_controller.dart';
import '../../data/workout_logs/firebase_workout_logs_repository.dart';
import '../../../lib/domain/entities/set_entry.dart';
import '../../data/workout_logs/workout_logs_repository.dart';

final workoutLogControllerProvider = StreamNotifierProvider<WorkoutLogController, List<SetEntry>>(
  () => WorkoutLogController(workoutLogsRepository: FirebaseWorkoutLogsRepository()),
);

class WorkoutLogController extends StreamNotifier<List<SetEntry>> {
  WorkoutLogController({required WorkoutLogsRepository workoutLogsRepository})
      : _workoutLogsRepository = workoutLogsRepository;

  final WorkoutLogsRepository _workoutLogsRepository;
  @override
  Stream<List<SetEntry>> build() {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;

    final exercisesAsyncValue = ref.watch(defaultExercisesControllerProvider);
    if (!exercisesAsyncValue.hasValue) {
      return Stream.value([]);
    }

    return _workoutLogsRepository.getWorkoutLogs(userId: userId);
  }

  Future<void> addLog(SetEntry log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.addWorkoutLog(userId: userId, workoutLog: log);
  }

  Future<void> updateLog(SetEntry log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.updateWorkoutLog(userId: userId, workoutLog: log);
  }

  Future<void> deleteLog(SetEntry log) async {
    final userId = ref.watch(authControllerProvider).asAuthenticated.user.id;
    await _workoutLogsRepository.deleteWorkoutLog(userId: userId, workoutLog: log);
  }
}
