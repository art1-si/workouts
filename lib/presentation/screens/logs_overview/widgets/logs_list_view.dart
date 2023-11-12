import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_for_date_controller.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/log_overview_card.dart';

class LogsListView extends ConsumerWidget {
  const LogsListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(workoutLogForDateProvider);
    return asyncList.when(
      data: (data) {
        final loggedSets = groupBy(data, (element) => element.exercise.exerciseName);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: loggedSets.keys.length,
          itemBuilder: (context, index) {
            return LogOverviewCard(
              workoutLog: loggedSets[loggedSets.keys.elementAt(index)]!,
            );
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
