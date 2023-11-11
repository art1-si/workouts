import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/data/exercises/exercises_repository.dart';
import 'package:workouts/data/exercises/firebase_exercises_repository.dart';
import 'package:workouts/data/exercises/model/exercise.dart';

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
}
