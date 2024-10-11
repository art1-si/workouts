import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/authentication_controller.dart';
import '../../data/exercises/exercises_repository.dart';
import '../../data/exercises/firebase_exercises_repository.dart';
import '../../../lib/domain/entities/exercise.dart';

/// User defined exercises Provider.
final userDefineExercisesControllerProvider = StreamNotifierProvider<UserDefineExercisesController, List<Exercise>>(() {
  return UserDefineExercisesController(
    exercisesRepository: FirebaseExercisesRepository(),
  );
});

/// User defined exercises controller.
class UserDefineExercisesController extends StreamNotifier<List<Exercise>> {
  UserDefineExercisesController({required ExercisesRepository exercisesRepository})
      : _exercisesRepository = exercisesRepository;

  final ExercisesRepository _exercisesRepository;

  @override
  Stream<List<Exercise>> build() {
    final user = ref.watch(authControllerProvider).asAuthenticated.user;
    return _exercisesRepository.getUserDefineExercises(userId: user.id);
  }

  Future<void> createExercise({required String exerciseName, required String exerciseType}) async {
    final user = ref.watch(authControllerProvider).asAuthenticated.user;
    await _exercisesRepository.createExercise(
      userId: user.id,
      exercise: Exercise(
        name: exerciseName,
        type: exerciseType,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }
}
