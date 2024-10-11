import 'package:flutter/material.dart';
import 'controller/graph_offset_point.dart';
import '../../../../../../../theme/app_colors.dart';

class LinerGraphPainter extends StatelessWidget {
  const LinerGraphPainter({
    Key? key,
    required this.graphOffsetPoints,
    required this.constraints,
    required this.lineColor,
    this.strokeWidth = 2,
  }) : super(key: key);

  final List<GraphOffsetPoint> graphOffsetPoints;
  final BoxConstraints constraints;
  final Color lineColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: DrawGraph(
          tapped: false,
          graphOffsetPoints: graphOffsetPoints,
          lineColor: lineColor,
          tappedLineColor: AppColors.accentSecondary,
          topGradientColor: Colors.white.withOpacity(0.1),
          bottomGradientColor: Colors.white.withOpacity(0.07),
          tappedBottomGradientColor: Colors.white.withOpacity(0.07),
          tappedTopGradientColor: Colors.white.withOpacity(0.1),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class DrawGraph extends CustomPainter {
  const DrawGraph({
    required this.topGradientColor,
    required this.bottomGradientColor,
    required this.tappedTopGradientColor,
    required this.tappedBottomGradientColor,
    required this.graphOffsetPoints,
    required this.lineColor,
    required this.tappedLineColor,
    required this.tapped,
    this.strokeWidth = 2,
  });

  final List<GraphOffsetPoint> graphOffsetPoints;
  final bool tapped;
  final Color lineColor;
  final Color tappedLineColor;
  final Color topGradientColor;
  final Color bottomGradientColor;
  final Color tappedTopGradientColor;
  final Color tappedBottomGradientColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    var gradientColorStarter = (!tapped) ? topGradientColor : tappedTopGradientColor;
    var endGradientColor = (!tapped) ? bottomGradientColor : tappedBottomGradientColor;
    final gradient = LinearGradient(
      colors: [gradientColorStarter, endGradientColor],
      stops: [0.6, 0.99],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    var shadowLine2 = Paint()
      ..shader = gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;

    var line2 = Paint()
      ..color = (!tapped) ? lineColor : tappedLineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;

    if (graphOffsetPoints.length > 1) {
      for (var i = 0; i < graphOffsetPoints.length; i++) {
        final point = graphOffsetPoints[i];
        final isLast = i == graphOffsetPoints.length - 1;
        if (isLast) {
          break;
        }
        final nextPoint = graphOffsetPoints[i + 1];

        var _dx = point.xAxis * size.width;
        var _dy = point.yAxis * size.height;
        var _nextDx = nextPoint.xAxis * size.width;
        var _nextDy = nextPoint.yAxis * size.height;

        //Draw main line
        canvas..drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);
      }
    } else {
      var _dx = 0.0;
      var _dy = size.height / 2;
      var _nextDx = size.width;
      var _nextDy = size.height / 2;
      //Draw main line

      canvas
        ..drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2)

        //Draw background
        ..drawPath(
          Path()
            ..moveTo(_dx, _dy)
            ..lineTo(_dx, size.height)
            ..lineTo(_nextDx, size.height)
            ..lineTo(_nextDx, _nextDy),
          shadowLine2,
        );
    }
  }

  @override
  bool shouldRepaint(DrawGraph oldDelegate) =>
      oldDelegate.tapped != tapped || oldDelegate.graphOffsetPoints != graphOffsetPoints;
}
