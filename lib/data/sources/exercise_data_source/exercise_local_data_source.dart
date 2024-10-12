import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/sources/local_data_source.dart';

final class ExerciseLocalDataSource extends LocalDataSource implements ExerciseDataSource {
  const ExerciseLocalDataSource({
    required super.sqlDatabaseClient,
  });

  static const _table = 'exercise';

  @override
  Future<List<ExerciseDto>> getExercises() async {
    final exercises = await sqlDatabaseClient.query(
      table: _table,
      parser: ExerciseDto.fromMap,
    );
    return exercises;
  }
}
