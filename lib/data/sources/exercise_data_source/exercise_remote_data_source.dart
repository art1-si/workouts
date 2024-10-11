import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/sources/remote_data_source.dart';

final class ExerciseRemoteDataSource extends RemoteDataSource implements ExerciseDataSource {
  ExerciseRemoteDataSource({
    required super.httpClient,
  });

  @override
  Future<List<ExerciseDto>> getExercises() {
    // TODO: implement getExercises
    throw UnimplementedError();
  }
}
