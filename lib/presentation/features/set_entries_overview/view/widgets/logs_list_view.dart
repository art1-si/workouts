import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../lib.old/application/workout_logs/workout_logs_view_model_controller.dart';
import '../../../../navigation/navigation_routes.dart';
import 'log_overview_card.dart';

class LogsListView extends ConsumerWidget {
  const LogsListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutLogsAsyncList = ref.watch(workoutLogsForSelectedDateProvider);
    return workoutLogsAsyncList.when(
      data: (data) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: 4,
          ),
          itemBuilder: (context, index) {
            return LogOverviewCard(
              title: data[index].exercise.exerciseName,
              workoutLog: data[index].workoutLog,
              onTap: () => context.pushNamed(NavigationRoute.logCreation.named,
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
