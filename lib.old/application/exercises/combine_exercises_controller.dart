import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'default_exercises_controller.dart';
import 'user_define_exercises_controller.dart';

import '../../../lib/domain/entities/exercise.dart';

/// Combines default and user defined exercises Provider.
final combineExercisesControllerProvider =
    StreamNotifierProvider<CombineExercisesController, List<Exercise>>(CombineExercisesController.new);

/// Combines default and user defined exercises controller.
class CombineExercisesController extends StreamNotifier<List<Exercise>> {
  CombineExercisesController();

  @override
  Stream<List<Exercise>> build() async* {
    final userDefineExercises = await ref.watch(userDefineExercisesControllerProvider.future);
    final defaultExercises = await ref.watch(defaultExercisesControllerProvider.future);

    yield [...userDefineExercises, ...defaultExercises];
  }
}
