import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/application/workout_logs/workout_logs_view_model_controller.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/log_overview_card.dart';

class LogsListView extends ConsumerWidget {
  const LogsListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutLogsAsyncList = ref.watch(workoutLogsForSelectedDateProvider);
    return workoutLogsAsyncList.when(
      data: (data) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return LogOverviewCard(
              title: data[index].exercise.exerciseName,
              workoutLog: data[index].workoutLog,
              onTap: () => context.pushNamed(Screens.logCreation.named,
                  extra: {'exercises': data.map((e) => e.exercise).toList(), 'indexOfSelectedExercise': index}),
            );
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
