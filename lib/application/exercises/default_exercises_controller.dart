import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/data/exercises/exercises_repository.dart';
import 'package:workouts/data/exercises/firebase_exercises_repository.dart';
import 'package:workouts/data/exercises/model/exercise.dart';

/// Default exercises Provider.
final defaultExercisesControllerProvider = StreamNotifierProvider<DefaultExercisesController, List<Exercise>>(() {
  return DefaultExercisesController(
    exercisesRepository: FirebaseExercisesRepository(),
  );
});

/// Default exercises controller.
class DefaultExercisesController extends StreamNotifier<List<Exercise>> {
  DefaultExercisesController({required ExercisesRepository exercisesRepository})
      : _exercisesRepository = exercisesRepository;

  final ExercisesRepository _exercisesRepository;

  @override
  Stream<List<Exercise>> build() {
    final user = ref.watch(authControllerProvider).asAuthenticated.user;
    return _exercisesRepository.getDefaultExercises(userId: user.id);
  }
}
