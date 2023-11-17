import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/selected_date/selected_date_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model_extension.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/create_new_entry.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/current_entries.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/new_entry_controller.dart';

class LogScreen extends ConsumerWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);
  final WorkoutLogViewModel exerciseLog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final newEntryController = NewEntryMediator(exerciseLog, selectedDate);

    return ListView(
      children: <Widget>[
        CreateNewEntry(
          newEntryController: newEntryController,
        ),
        CurrentEntries(
          newEntryMediator: newEntryController,
          currentEntry: exerciseLog.workoutLogsForDate(selectedDate),
        ),
      ],
    );
  }
}