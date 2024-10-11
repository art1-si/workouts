import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/sources/local_data_source.dart';

final class ExerciseLocalDataSource extends LocalDataSource implements ExerciseDataSource {
  @override
  Future<List<ExerciseDto>> getExercises() {
    // TODO: implement getExercises
    throw UnimplementedError();
  }
}
