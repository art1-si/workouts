import 'package:workouts/data/database/firestore_service.dart';
import 'package:workouts/data/exercises/exercises_repository.dart';
import 'package:workouts/data/exercises/model/exercise.dart';

class FirebaseExercisesRepository implements ExercisesRepository {
  final _firestore = FirestoreService.instance;
  @override
  Future<void> createExercise({required String userId, required Exercise exercise}) {
    return _firestore.setData(
      path: 'users/$userId/customExercises/${exercise.id}',
      data: {
        'exerciseName': exercise.exerciseName,
        'exerciseType': exercise.exerciseType,
        'id': exercise.id,
      },
    );
  }

  @override
  Future<void> deleteExercise({required Exercise exercise, required String userId}) {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  Stream<List<Exercise>> getDefaultExercises({required String userId}) {
    return _firestore.collectionStream(path: 'exercises', builder: (data, id) => Exercise.fromMap(data));
  }

  @override
  Future<void> updateExercise({required Exercise exercise, required String userId}) {
    // TODO: implement updateExercise
    throw UnimplementedError();
  }

  @override
  Stream<List<Exercise>> getUserDefineExercises({required String userId}) {
    return _firestore.collectionStream(
        path: 'users/$userId/customExercises', builder: (data, id) => Exercise.fromMap(data));
  }
}
