import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_graph.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_point.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/graph_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/line_divider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/onPressDialog.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';

class WorkoutOverviewGraph extends StatefulWidget {
  WorkoutOverviewGraph({
    Key? key,
    required List<WorkoutLog> workoutLogs,
    this.onElementSelected,
  })  : graphViewController =
            GraphViewController(data: workoutLogs, valueYGetter: (log) => epleyCalOneRepMax(log.weight, log.reps)),
        super(key: key);

  final GraphViewController<WorkoutLog> graphViewController;
  final void Function(WorkoutLog?)? onElementSelected;

  @override
  State<WorkoutOverviewGraph> createState() => _WorkoutOverviewGraphState();
}

class _WorkoutOverviewGraphState extends State<WorkoutOverviewGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        // const PropertiesDropDown(),
        OnPressDialog(
          details: widget.graphViewController.pressedElement ?? widget.graphViewController.graphPoints.last,
        ),
        Expanded(
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
                    widget.graphViewController.setTappedEntryByOffset(_res);
                    setState(() {
                      widget.onElementSelected?.call(widget.graphViewController.pressedElement!.data);
                    });
                  },
                  onPanStart: (details) {
                    var _res = Offset(
                      getXOffset(details.globalPosition.dx),
                      details.globalPosition.dy,
                    );
                    widget.graphViewController.setTappedEntryByOffset(_res);
                    setState(() {
                      widget.onElementSelected?.call(widget.graphViewController.pressedElement!.data);
                    });
                  },
                  onPanUpdate: (details) {
                    var _res = Offset(
                      getXOffset(details.globalPosition.dx),
                      details.globalPosition.dy,
                    );
                    widget.graphViewController.setTappedEntryByOffset(_res);
                    setState(() {
                      widget.onElementSelected?.call(widget.graphViewController.pressedElement!.data);
                    });
                  },
                  onPanEnd: (details) {
                    widget.graphViewController.resetPressedElement();
                    setState(() {
                      widget.onElementSelected?.call(null);
                    });
                  },
                  onPanCancel: () {
                    widget.graphViewController.resetPressedElement();
                    setState(() {
                      widget.onElementSelected?.call(null);
                    });
                  },
                  child: Stack(
                    children: [
                      LineDividers(
                        graphViewController: widget.graphViewController,
                      ),
                      LinerGraph(
                        data: widget.graphViewController.graphPoints,
                        isPressed: widget.graphViewController.pressedElement != null,
                      ),
                      Builder(
                        builder: (context) {
                          if (widget.graphViewController.pressedElement == null) {
                            return const SizedBox();
                          } else {
                            return GraphPoint(
                              entry: widget.graphViewController.pressedElement!,
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
        const SizedBox(height: 240)
      ],
    );
  }
}
