import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../lib.old/application/workout_logs/models/workout_log_view_model.dart';
import '../../../../../../../lib.old/application/workout_logs/models/workout_log_view_model_extension.dart';
import 'create_new_entry.dart';
import 'current_entries.dart';
import 'new_entry_controller.dart';
import '../../../../../../../lib.old/presentation/widgets/widget_block.dart';

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
