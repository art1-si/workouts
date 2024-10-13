import 'package:workouts/data/data_sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/data_sources/exercise_data_source/exercise_in_memory_data_source.dart';
import 'package:workouts/data/data_sources/exercise_data_source/exercise_local_data_source.dart';
import 'package:workouts/data/data_sources/exercise_data_source/exercise_remote_data_source/exercise_remote_data_source.dart';
import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/exceptions/data_source_exceptions.dart';

class ExerciseDataSourceManager implements ExerciseDataSource {
  ExerciseDataSourceManager({
    required ExerciseRemoteDataSource exerciseRemoteDataSource,
    required ExerciseLocalDataSource exerciseLocalDataSource,
    required ExerciseInMemoryDataSource exerciseInMemoryDataSource,
  })  : _exerciseRemoteDataSource = exerciseRemoteDataSource,
        _exerciseLocalDataSource = exerciseLocalDataSource,
        _exerciseInMemoryDataSource = exerciseInMemoryDataSource;

  final ExerciseRemoteDataSource _exerciseRemoteDataSource;
  final ExerciseLocalDataSource _exerciseLocalDataSource;
  final ExerciseInMemoryDataSource _exerciseInMemoryDataSource;

  @override
  Future<List<ExerciseDto>> getExercises() {
    try {
      return _exerciseInMemoryDataSource.getExercises();
    } on InMemoryDataNotFoundException {
      try {
        return _exerciseRemoteDataSource.getExercises();
      } catch (_) {
        return _exerciseLocalDataSource.getExercises();
      }
    }
  }
}
