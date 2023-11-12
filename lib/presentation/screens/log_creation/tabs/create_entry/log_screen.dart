import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/selected_date/selected_date_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/create_new_entry.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/current_entries.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/bottom_buttons.dart';

class LogScreen extends ConsumerWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);
  final List<WorkoutLogViewModel> exerciseLog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    return ListView(
      children: <Widget>[
        const CreateNewEntry(
          bottomButtons: RowWithBottomButtons(),
        ),
        const Divider(
          thickness: 0.5,
          height: 20,
        ),
        CurrentEntries(
          onLongPressed: (log) {},
          currentEntries: exerciseLog.where((element) => element.workoutLog.dateCreated.isEqual(selectedDate)).toList(),
        ),
      ],
    );
  }
}
