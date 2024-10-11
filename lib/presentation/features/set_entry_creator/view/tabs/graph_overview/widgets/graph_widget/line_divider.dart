import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/graph_view_controller.dart';
import '../../../rep_max_view.dart';
import '../../../../../../../theme/app_colors.dart';

class LineDividers extends ConsumerWidget {
  const LineDividers({
    Key? key,
    required this.graphViewController,
  }) : super(key: key);

  final GraphViewController graphViewController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return RepaintBoundary(
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _DrawLines(
            dividerColor: AppColors.primaryShades.shade80,
            highestValue: graphViewController.greatestValue,
            lowestValue: graphViewController.smallestValue,
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
  });
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
  }

  @override
  bool shouldRepaint(covariant _DrawLines oldDelegate) {
    return oldDelegate.highestValue != highestValue || oldDelegate.lowestValue != lowestValue;
  }
}
