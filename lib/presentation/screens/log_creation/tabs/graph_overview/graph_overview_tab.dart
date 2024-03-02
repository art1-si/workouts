import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/services/graph_selector_provider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/log_graph.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

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

    return Container(
        color: AppColors.primaryShades.shade110,
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                workoutLogs: workoutLogs,
                graphProperties: GraphProperties.oneRepMax,
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                workoutLogs: workoutLogs,
                graphProperties: GraphProperties.perWeight,
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                workoutLogs: workoutLogs,
                graphProperties: GraphProperties.simpleVolumePerSet,
              ),
            ),
          ],
        ));
  }
}
