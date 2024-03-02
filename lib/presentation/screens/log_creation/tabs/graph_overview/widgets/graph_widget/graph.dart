import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/controller/graph_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_graph.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/draw_point.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/line_divider.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class LinearGraph<XAxisT> extends StatefulWidget {
  LinearGraph({
    super.key,
    required this.graphViewController,
    this.showAverageLine = true,
  });

  final GraphViewController graphViewController;
  final bool showAverageLine;

  @override
  State<LinearGraph> createState() => _LinearGraphState();
}

class _LinearGraphState extends State<LinearGraph> {
  GraphViewController get graphViewController => widget.graphViewController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LineDividers(
          graphViewController: widget.graphViewController,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: LayoutBuilder(builder: (context, constrains) {
            double getXOffset(double dx) {
              return (dx / constrains.maxWidth);
            }

            return GestureDetector(
              onPanDown: (details) {
                var _res = Offset(
                  getXOffset(details.localPosition.dx),
                  details.globalPosition.dy,
                );
                graphViewController.setPressElementIndexOnPressedOffset(_res);
              },
              onPanStart: (details) {
                var _res = Offset(
                  getXOffset(details.localPosition.dx),
                  details.globalPosition.dy,
                );
                graphViewController.setPressElementIndexOnPressedOffset(_res);
              },
              onPanUpdate: (details) {
                var _res = Offset(
                  getXOffset(details.localPosition.dx),
                  details.globalPosition.dy,
                );
                graphViewController.setPressElementIndexOnPressedOffset(_res);
              },
              onPanEnd: (details) {
                graphViewController.resetPressedElementIndex();
              },
              onPanCancel: () {
                graphViewController.resetPressedElementIndex();
              },
              child: Stack(
                children: [
                  LinerGraphPainter(
                    lineColor: AppColors.accent.withOpacity(0.5),
                    graphOffsetPoints: widget.graphViewController.graphOffsetPoints,
                    constraints: constrains,
                    strokeWidth: 2,
                  ),
                  LinerGraphPainter(
                    lineColor: AppColors.accentSecondary,
                    graphOffsetPoints: widget.graphViewController.trendGraphOffsetPoints,
                    constraints: constrains,
                    strokeWidth: 2,
                  ),
                  ListenableBuilder(
                    listenable: graphViewController.pressedElementIndex,
                    builder: (context, child) {
                      final pressedIndex = graphViewController.pressedElementIndex.value;
                      if (pressedIndex == null) {
                        return const SizedBox();
                      } else {
                        return GraphPoint(
                          pressedElementPoint: graphViewController.graphOffsetPoints[pressedIndex],
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
