import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/history_page/history_table.dart';
import 'package:workouts/presentation/theme/typography.dart';

class HistoryView extends StatelessWidget {
  final List<WorkoutLog> exerciseLog;
  HistoryView({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (exerciseLog.isEmpty) {
      return Center(
        child: StyledText.headline1('EMPTY LOG'),
      );
    }

    return HistoryTable(model: exerciseLog.reversed.toList());
  }
}
