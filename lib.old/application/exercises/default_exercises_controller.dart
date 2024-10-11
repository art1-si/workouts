import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/authentication_controller.dart';
import '../../data/exercises/exercises_repository.dart';
import '../../data/exercises/firebase_exercises_repository.dart';
import '../../../lib/domain/entities/exercise.dart';

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
