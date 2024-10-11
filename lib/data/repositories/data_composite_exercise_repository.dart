import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/repositories/exercise_repository.dart';

extension ToExerciseEntity on ExerciseDto {
  Exercise toExerciseEntity() {
    return Exercise(
      id: id,
      name: name,
      type: type,
    );
  }
}

class DataCompositeExerciseRepository implements ExerciseRepository {
  DataCompositeExerciseRepository({
    required ExerciseDataSource exerciseDataSource,
  }) : _exerciseDataSource = exerciseDataSource;

  final ExerciseDataSource _exerciseDataSource;

  @override
  Future<List<Exercise>> getExercises() async {
    final data = await _exerciseDataSource.getExercises();
    return data.map((e) => e.toExerciseEntity()).toList();
  }
}
