import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph.dart';

import 'package:workouts/presentation/theme/typography.dart';

class GraphOverviewTab extends StatelessWidget {
  final List<WorkoutLog> workoutLogs;
  GraphOverviewTab({
    Key? key,
    required this.workoutLogs,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    if (workoutLogs.isEmpty) {
      return Center(
        child: StyledText.headline('EMPTY LOG'),
      );
    }

    return WorkoutOverviewGraph(workoutLogs: workoutLogs);
  }
}
