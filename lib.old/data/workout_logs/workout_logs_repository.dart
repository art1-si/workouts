import '../../../lib/domain/entities/set_entry.dart';

abstract interface class WorkoutLogsRepository {
  Stream<List<SetEntry>> getWorkoutLogs({required String userId});

  Future<void> addWorkoutLog({required String userId, required SetEntry workoutLog});

  Future<void> updateWorkoutLog({required String userId, required SetEntry workoutLog});

  Future<void> deleteWorkoutLog({required String userId, required SetEntry workoutLog});
}
