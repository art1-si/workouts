import 'package:workouts/data/dto_models/exercise_dto.dart';

abstract interface class ExerciseDataSource {
  Future<List<ExerciseDto>> getExercises();
}
