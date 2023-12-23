import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/application/exercises/combine_exercises_controller.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/screens/exercise_selector/widgets/exapndable_list_view.dart';

class ExerciseSelectorScreen extends ConsumerWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsyncValue = ref.watch(combineExercisesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          exercisesAsyncValue.when(
            data: (data) => IconButton(
              onPressed: () => context.pushNamed(Screens.exerciseCreation.named, extra: data),
              icon: const Icon(Icons.add),
            ),
            loading: () => const SizedBox(),
            error: (error, stackTrace) => const SizedBox(),
          ),
        ],
        elevation: 0,
        title: const Text('Select Exercises'),
      ),
      body: exercisesAsyncValue.when(
        // onTap: () => context.pushNamed(Screens.logCreation.named,
        //     extra: {'exercises': widget.subElements, 'indexOfSelectedExercise': index}),
        data: (data) => ExpandableListView<String, Exercise>(
          entries: data,
          subElementTitle: (exercise) => exercise.exerciseName,
          groupBy: (exercise) => exercise.exerciseType,
          groupTitle: (group) => group,
          onTap: (exercises, index) => context
              .pushNamed(Screens.logCreation.named, extra: {'exercises': exercises, 'indexOfSelectedExercise': index}),
        ),
        // ExerciseSelectorList(exercises: data),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
      ),
    );
  }
}
