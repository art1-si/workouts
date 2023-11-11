import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_for_date_controller.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/log_overview_card.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';

class LogsListView extends ConsumerWidget {
  const LogsListView({
    super.key,
    required this.datePickerController,
  });
  final CalendarDatePickerController datePickerController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: datePickerController.startDateNotifier,
        builder: (context, value, child) {
          final asyncList = ref.watch(workoutLogForDateProvider(value!));
          print(asyncList);
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
        });
  }
}
