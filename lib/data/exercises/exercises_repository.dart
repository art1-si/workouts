import 'package:workouts/data/exercises/model/exercise.dart';

abstract interface class ExercisesRepository {
  /// Returns a list of exercises.
  Stream<List<Exercise>> getDefaultExercises({required String userId});

  /// Returns a list of exercises made by user.
  Stream<List<Exercise>> getUserDefineExercises({required String userId});

  /// Adds a new exercise.
  Future<void> createExercise({required String userId, required Exercise exercise});

  /// Deletes an exercise.
  Future<void> deleteExercise({required Exercise exercise, required String userId});

  /// Updates an exercise.
  Future<void> updateExercise({required Exercise exercise, required String userId});
}
