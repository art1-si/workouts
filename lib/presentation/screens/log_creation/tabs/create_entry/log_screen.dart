import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model_extension.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/create_new_entry.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/current_entries.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/new_entry_controller.dart';
import 'package:workouts/presentation/widgets/widget_block.dart';

class LogScreen extends ConsumerWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
    required this.selectedDate,
  }) : super(key: key);
  final WorkoutLogViewModel exerciseLog;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newEntryMediator = ref.watch(newEntryMediatorProvider(exerciseLog));
    return Container(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          WidgetBlock(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CreateNewEntry(
                newEntryController: newEntryMediator,
              ),
            ),
          ),
          CurrentEntries(
            newEntryMediator: newEntryMediator,
            currentEntry: exerciseLog.workoutLogsForDate(selectedDate),
          ),
        ],
      ),
    );
  }
}
