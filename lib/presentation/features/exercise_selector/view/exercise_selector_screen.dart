import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../lib.old/application/exercises/combine_exercises_controller.dart';
import '../../../../../lib.old/data/exercises/model/exercise.dart';
import '../../../navigation/navigation_routes.dart';
import 'widgets/exapndable_list_view.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/typography.dart';

class ExerciseSelectorScreen extends ConsumerWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsyncValue = ref.watch(combineExercisesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryShades.shade90,
        scrolledUnderElevation: 0,
        actions: [
          exercisesAsyncValue.when(
            data: (data) => IconButton(
              onPressed: () => context.pushNamed(NavigationRoute.exerciseCreation.named, extra: data),
              icon: const Icon(Icons.add),
            ),
            loading: () => const SizedBox(),
            error: (error, stackTrace) => const SizedBox(),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        title: StyledText.headlineSmall('Select Exercises'),
      ),
      body: exercisesAsyncValue.when(
        data: (data) => ExpandableListView<String, Exercise>(
          entries: data,
          subElementTitle: (exercise) => exercise.exerciseName,
          groupBy: (exercise) => exercise.exerciseType,
          groupTitle: (group) => group,
          onTap: (exercises, index) => context.pushNamed(NavigationRoute.logCreation.named,
              extra: {'exercises': exercises, 'indexOfSelectedExercise': index}),
        ),
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
