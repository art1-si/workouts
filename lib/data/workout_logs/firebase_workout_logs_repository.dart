import 'package:workouts/data/database/firestore_service.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/data/workout_logs/workout_logs_repository.dart';

class FirebaseWorkoutLogsRepository implements WorkoutLogsRepository {
  final _firestore = FirestoreService.instance;
  @override
  Stream<List<WorkoutLog>> getWorkoutLogs({required String userId}) {
    return _firestore.collectionStream(
        path: 'users/$userId/exerciseLog', builder: (data, id) => WorkoutLog.fromMap(data));
  }

  @override
  Future<void> addWorkoutLog({required String userId, required WorkoutLog workoutLog}) {
    return _firestore.setData(path: 'users/$userId/exerciseLog/${workoutLog.id}', data: workoutLog.toMap());
  }

  @override
  Future<void> updateWorkoutLog({required String userId, required WorkoutLog workoutLog}) {
    return _firestore.updateData(
      path: 'users/$userId/exerciseLog/${workoutLog.id}',
      data: workoutLog.toMap(),
    );
  }

  @override
  Future<void> deleteWorkoutLog({required String userId, required WorkoutLog workoutLog}) {
    return _firestore.deleteData(path: 'users/$userId/exerciseLog/${workoutLog.id}');
  }
}
