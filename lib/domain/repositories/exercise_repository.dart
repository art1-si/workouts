import 'package:workouts/domain/entities/exercise.dart';

abstract interface class ExerciseRepository {
  /// Returns a list of available exercises.
  Future<List<Exercise>> getExercises();
}
