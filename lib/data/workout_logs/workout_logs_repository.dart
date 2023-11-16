import 'package:workouts/data/workout_logs/models/workout_log.dart';

abstract interface class WorkoutLogsRepository {
  Stream<List<WorkoutLog>> getWorkoutLogs({required String userId});

  Future<void> addWorkoutLog({required String userId, required WorkoutLog workoutLog});

  Future<void> updateWorkoutLog({required String userId, required WorkoutLog workoutLog});

  Future<void> deleteWorkoutLog({required String userId, required WorkoutLog workoutLog});
}
