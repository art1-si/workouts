import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/controller/graph_offset_point.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class GraphPoint extends StatelessWidget {
  const GraphPoint({Key? key, required this.pressedElementPoint}) : super(key: key);

  final GraphOffsetPoint pressedElementPoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: DrawPoint(
          pressedElementPoint: pressedElementPoint,
          color: AppColors.accentSecondary,
          topGradientColor: AppColors.accent.withOpacity(0.5),
          bottomGradientColor: AppColors.accent.withOpacity(0.5),
        ),
      );
    });
  }
}

class DrawPoint extends CustomPainter {
  const DrawPoint({
    required this.pressedElementPoint,
    required this.color,
    required this.topGradientColor,
    required this.bottomGradientColor,
  });

  final GraphOffsetPoint pressedElementPoint;
  final Color color;
  final Color topGradientColor;
  final Color bottomGradientColor;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [topGradientColor, bottomGradientColor],
      stops: [0.2, 0.99],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    var shadowLine2 = Paint()
      ..shader = gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    var points = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 8;

    //var _dx = pointPosition.x * size.width;
    // var _nextDx = pointPosition.nextX * size.width;
    //var _distance = (_nextDx - _dx) / 2;
    /* canvas.drawPath(
      Path()
        ..moveTo(_dx - _distance, 0)
        ..lineTo(_dx - _distance, size.height)
        ..lineTo(_nextDx - _distance, size.height)
        ..lineTo(_nextDx - _distance, 0),
      shadowLine2,
    ); */
    canvas
      ..drawLine(Offset((pressedElementPoint.xAxis * size.width), 0),
          Offset(pressedElementPoint.xAxis * size.width, size.height), shadowLine2)
      ..drawLine(Offset((pressedElementPoint.xAxis * size.width), pressedElementPoint.yAxis * size.height),
          Offset(pressedElementPoint.xAxis * size.width, pressedElementPoint.yAxis * size.height), points);
  }

  @override
  bool shouldRepaint(DrawPoint oldDelegate) => oldDelegate.pressedElementPoint != pressedElementPoint;
}
