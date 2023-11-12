import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/create_new_entry.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/current_entries.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/bottom_buttons.dart';

class LogScreen extends StatelessWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);
  final List<WorkoutLogViewModel> exerciseLog;

  @override
  Widget build(BuildContext context) {
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
          currentEntries: [],
          // exerciseLog
          //     .where((element) => compareDatesToDay(
          //           DateTime.tryParse(element.dateCreated)!,
          //           context.read(selectedDateProvider).daySelected,
          //         ))
          //     .toList(),
        ),
      ],
    );
  }
}
