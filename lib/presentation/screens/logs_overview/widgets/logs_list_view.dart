import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_for_date_controller.dart';
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].exerciseID),
                    subtitle: Text(data[index].dateCreated),
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
