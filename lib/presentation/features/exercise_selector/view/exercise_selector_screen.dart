import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/presentation/features/exercise_selector/bloc/exercise_selector_bloc.dart';
import 'package:workouts/presentation/navigation/navigation_routes.dart';
import 'package:workouts/presentation/shared/widgets/buttons/retry_button.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'widgets/expandable_list_view.dart';

class ExerciseSelectorScreen extends StatelessWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryShades.shade90,
        scrolledUnderElevation: 0,
        actions: [
          //TODO(Artur):Add search and add buttons
        ],
        elevation: 0,
        centerTitle: true,
        title: StyledText.headlineSmall('Select Exercises'),
      ),
      body: BlocBuilder<ExerciseSelectorBloc, ExerciseSelectorState>(builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (data) => ExpandableListView<String, Exercise>(
            entries: data,
            subElementTitle: (exercise) => exercise.name,
            groupBy: (exercise) => exercise.type,
            groupTitle: (group) => group,
            onTap: (exercises, index) => context.pushNamed(NavigationRoute.logCreation.named,
                extra: {'exercises': exercises, 'indexOfSelectedExercise': index}),
          ),
          error: (error) => Center(
            child: RetryButton(
              onPressed: () => context.read<ExerciseSelectorBloc>().add(const GetAllAvailableExercisesEvent()),
            ),
          ),
        );
      }),
    );
  }
}
