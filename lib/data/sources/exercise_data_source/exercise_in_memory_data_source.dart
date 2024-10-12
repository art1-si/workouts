import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/exceptions/data_source_exceptions.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/sources/in_memory_data_source.dart';

final class ExerciseInMemoryDataSource extends InMemoryDataSource<List<ExerciseDto>> implements ExerciseDataSource {
  @override
  Future<List<ExerciseDto>> getExercises() async {
    final cache = cachedData;
    if (cache != null) {
      return cache;
    }
    throw const InMemoryDataNotFoundException();
  }
}
