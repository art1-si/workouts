import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/repositories/exercise_repository.dart';
import 'package:workouts/domain/use_cases/use_case.dart';

final class GetAllAvailableExercises extends UseCase<List<Exercise>> {
  GetAllAvailableExercises({
    required ExerciseRepository exerciseRepository,
  }) : _exerciseRepository = exerciseRepository;

  final ExerciseRepository _exerciseRepository;
  @override
  Future<List<Exercise>> execute() {
    return _exerciseRepository.getExercises();
  }
}
