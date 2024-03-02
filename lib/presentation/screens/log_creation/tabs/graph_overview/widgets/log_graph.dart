import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/services/graph_selector_provider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/controller/graph_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/graph.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/onPressDialog.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/widget_block.dart';

class WorkoutOverviewGraph extends StatefulWidget {
  WorkoutOverviewGraph({
    Key? key,
    required this.workoutLogs,
    required this.graphProperties,
    this.showDetails = true,
  }) : super(key: key);

  final List<WorkoutLog> workoutLogs;
  final GraphProperties graphProperties;
  final bool showDetails;

  @override
  State<WorkoutOverviewGraph> createState() => _WorkoutOverviewGraphState();
}

class _WorkoutOverviewGraphState extends State<WorkoutOverviewGraph> {
  double valueYGetter(WorkoutLog log) {
    switch (widget.graphProperties) {
      case GraphProperties.oneRepMax:
        return epleyCalOneRepMax(log.weight, log.reps);
      case GraphProperties.perWeight:
        return log.weight;
      case GraphProperties.simpleVolumePerSet:
        return log.weight * log.reps.toDouble();
    }
  }

  late final graphViewController = GraphViewController(
    graphElements: widget.workoutLogs
        .map(
          (e) => (yAxis: valueYGetter(e), xAxis: e.dateCreated),
        )
        .toList(),
  );

  @override
  Widget build(BuildContext context) {
    return WidgetBlock(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: widget.showDetails ? 16.0 : 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StyledText.labelLarge(
                widget.graphProperties.propertiesToString(),
              ),
            ),
          ),
          if (widget.showDetails)
            ListenableBuilder(
              listenable: graphViewController.pressedElementIndex,
              builder: (context, child) {
                return OnPressDialog(
                  log: graphViewController.pressedElementIndex.value != null
                      ? widget.workoutLogs[graphViewController.pressedElementIndex.value!]
                      : widget.workoutLogs.last,
                  valueBuilder: valueYGetter,
                );
              },
            ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 32,
                  bottom: 16,
                ),
                child: LinearGraph(
                  graphViewController: graphViewController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
