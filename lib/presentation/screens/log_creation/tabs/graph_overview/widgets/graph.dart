import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/services/graph_selector_provider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_graph.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_point.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/graph_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/line_divider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/onPressDialog.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/proerties_drop_down_menu.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/widgets/widget_block.dart';

class WorkoutOverviewGraph extends StatefulWidget {
  WorkoutOverviewGraph({
    Key? key,
    required this.workoutLogs,
    this.onElementSelected,
  }) : super(key: key);

  final List<WorkoutLog> workoutLogs;
  final void Function(WorkoutLog?)? onElementSelected;

  @override
  State<WorkoutOverviewGraph> createState() => _WorkoutOverviewGraphState();
}

class _WorkoutOverviewGraphState extends State<WorkoutOverviewGraph> {
  var _graphProperties = GraphProperties.oneRepMax;

  double valueYGetter(WorkoutLog log) {
    switch (_graphProperties) {
      case GraphProperties.oneRepMax:
        return epleyCalOneRepMax(log.weight, log.reps);
      case GraphProperties.perWeight:
        return log.weight;
      case GraphProperties.simpleVolumePerSet:
        return log.weight * log.reps.toDouble();
    }
  }

  late var graphViewController = GraphViewController(data: widget.workoutLogs, valueYGetter: valueYGetter);

  @override
  Widget build(BuildContext context) {
    return WidgetBlock(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PropertiesDropDown(
            initialValue: _graphProperties,
            onChanged: (value) {
              setState(() {
                _graphProperties = value;
                graphViewController = GraphViewController(data: widget.workoutLogs, valueYGetter: valueYGetter);
              });
            },
          ),
          OnPressDialog(
            details: graphViewController.pressedElement ?? graphViewController.graphPoints.last,
          ),
          SizedBox(
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                //color: AppColors.primaryShades.shade90,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 32,
                  bottom: 16,
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  var _width = constraints.maxWidth;

                  double getXOffset(double dx) {
                    return ((dx - 16) / _width);
                  }

                  return GestureDetector(
                    onPanDown: (details) {
                      var _res = Offset(
                        getXOffset(details.globalPosition.dx),
                        details.globalPosition.dy,
                      );
                      graphViewController.setTappedEntryByOffset(_res);
                      setState(() {
                        widget.onElementSelected?.call(graphViewController.pressedElement!.data);
                      });
                    },
                    onPanStart: (details) {
                      var _res = Offset(
                        getXOffset(details.globalPosition.dx),
                        details.globalPosition.dy,
                      );
                      graphViewController.setTappedEntryByOffset(_res);
                      setState(() {
                        widget.onElementSelected?.call(graphViewController.pressedElement!.data);
                      });
                    },
                    onPanUpdate: (details) {
                      var _res = Offset(
                        getXOffset(details.globalPosition.dx),
                        details.globalPosition.dy,
                      );
                      graphViewController.setTappedEntryByOffset(_res);
                      setState(() {
                        widget.onElementSelected?.call(graphViewController.pressedElement!.data);
                      });
                    },
                    onPanEnd: (details) {
                      graphViewController.resetPressedElement();
                      setState(() {
                        widget.onElementSelected?.call(null);
                      });
                    },
                    onPanCancel: () {
                      graphViewController.resetPressedElement();
                      setState(() {
                        widget.onElementSelected?.call(null);
                      });
                    },
                    child: Stack(
                      children: [
                        LineDividers(
                          graphViewController: graphViewController,
                        ),
                        LinerGraph(
                          data: graphViewController.graphPoints,
                          isPressed: graphViewController.pressedElement != null,
                        ),
                        Builder(
                          builder: (context) {
                            if (graphViewController.pressedElement == null) {
                              return const SizedBox();
                            } else {
                              return GraphPoint(
                                entry: graphViewController.pressedElement!,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
