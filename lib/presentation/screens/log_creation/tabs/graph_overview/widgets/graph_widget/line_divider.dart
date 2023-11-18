import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/graph_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class LineDividers extends ConsumerWidget {
  const LineDividers({
    Key? key,
    required this.graphViewController,
  }) : super(key: key);

  final GraphViewController graphViewController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstElement = graphViewController.graphPoints.first;
    final _distance = firstElement.nextX - firstElement.x;
    return LayoutBuilder(builder: (context, constraints) {
      return RepaintBoundary(
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _DrawLines(
            dividerColor: AppColors.primaryShades.shade80,
            distance: _distance,
            highestValue: graphViewController.maxValue,
            lowestValue: graphViewController.minValue,
          ),
        ),
      );
    });
  }
}

class _DrawLines extends CustomPainter {
  _DrawLines({
    required this.lowestValue,
    required this.highestValue,
    required this.dividerColor,
    required this.distance,
  });
  final double distance;
  final double? lowestValue;
  final double highestValue;
  final Color dividerColor;

  @override
  void paint(Canvas canvas, Size size) {
    createdWeightParagraph(Canvas canvas, paragraphXoffset, text) {
      final textStyle = ui.TextStyle(
        color: Colors.white54,
        fontSize: 10,
        letterSpacing: 1.5,
      );
      final paragraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr,
      );
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText('$text');
      final constraints = const ui.ParagraphConstraints(width: 50);
      final paragraph = paragraphBuilder.build()..layout(constraints);
      return canvas.drawParagraph(paragraph, Offset(0, paragraphXoffset));
    }

    var dividerLine = Paint()
      ..color = dividerColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5;
    if (lowestValue != null && lowestValue != highestValue) {
      var weightValue = lowestValue;
      for (var i = 0; i < 4; i++) {
        var weightGraphValue = roundDouble(weightValue!, 2);
        var relativeYposition = (weightGraphValue - lowestValue!) / (highestValue - lowestValue!);
        var yOffset = size.height - relativeYposition * size.height;

        canvas.drawLine(Offset(0, yOffset), Offset(size.width, yOffset), dividerLine);

        createdWeightParagraph(canvas, yOffset - 12, weightGraphValue);

        weightValue += (highestValue - lowestValue!) / 3;
      }
    } else {
      createdWeightParagraph(canvas, size.height / 2, highestValue);

      canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), dividerLine);
    }
    var gridGap = size.width / 5;
    var _distanceToSize = (distance) * size.width;
    var _correspondingGap = _distanceToSize;
    while (_correspondingGap < gridGap) {
      _correspondingGap = _correspondingGap + _distanceToSize;
    }
    // var gap = 0.07 * size.width; //*may couse bugs in graph layout part 2
    // for (var i = 0; i < 5; i++) {
    //   canvas.drawLine(Offset(gap, -10), Offset(gap, size.height), dividerLine);
    //   gap = gap + _correspondingGap;
    // }
  }

  @override
  bool shouldRepaint(covariant _DrawLines oldDelegate) {
    return oldDelegate.highestValue != highestValue || oldDelegate.lowestValue != lowestValue;
  }
}
