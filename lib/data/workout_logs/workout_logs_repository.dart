import 'package:workouts/data/workout_logs/models/workout_log.dart';

abstract interface class WorkoutLogsRepository {
  Stream<List<WorkoutLog>> getWorkoutLogs({required String userId});
}
