import 'package:workouts/data/database/firestore_service.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/data/workout_logs/workout_logs_repository.dart';

class FirebaseWorkoutLogsRepository implements WorkoutLogsRepository<Stream> {
  final _firestore = FirestoreService.instance;
  @override
  Stream<List<WorkoutLog>> getWorkoutLogs({required String userId}) {
    return _firestore.collectionStream(
        path: 'users/$userId/exerciseLog', builder: (data, id) => WorkoutLog.fromMap(data));
  }
}
