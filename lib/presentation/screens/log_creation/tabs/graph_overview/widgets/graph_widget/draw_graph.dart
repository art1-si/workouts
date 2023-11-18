import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/model/graph_model.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class LinerGraph extends StatelessWidget {
  const LinerGraph({
    Key? key,
    required this.data,
    required this.isPressed,
  }) : super(key: key);

  final List<GraphModel> data;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RepaintBoundary(
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: DrawGraph(
            tapped: isPressed,
            entries: data,
            lineColor: AppColors.accent,
            tappedLineColor: AppColors.accentSecondary,
            topGradientColor: Colors.white.withOpacity(0.1),
            bottomGradientColor: Colors.white.withOpacity(0.07),
            tappedBottomGradientColor: Colors.white.withOpacity(0.07),
            tappedTopGradientColor: Colors.white.withOpacity(0.1),
          ),
        ),
      );
    });
  }
}

class DrawGraph extends CustomPainter {
  const DrawGraph({
    required this.topGradientColor,
    required this.bottomGradientColor,
    required this.tappedTopGradientColor,
    required this.tappedBottomGradientColor,
    required this.entries,
    required this.lineColor,
    required this.tappedLineColor,
    required this.tapped,
  });

  final List<GraphModel> entries;
  final bool tapped;
  final Color lineColor;
  final Color tappedLineColor;
  final Color topGradientColor;
  final Color bottomGradientColor;
  final Color tappedTopGradientColor;
  final Color tappedBottomGradientColor;

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
      ..strokeWidth = 2;

    var line2 = Paint()
      ..color = (!tapped) ? lineColor : tappedLineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    if (entries.length > 1) {
      for (var element in entries) {
        var _dx = element.x * size.width;
        var _dy = element.y * size.height;
        var _nextDx = element.nextX * size.width;
        var _nextDy = element.nextY * size.height;
        //Draw main line

        canvas..drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);

        //Draw background
        // ..drawPath(
        //   Path()
        //     ..moveTo(_dx, _dy)
        //     ..lineTo(_dx, size.height)
        //     ..lineTo(_nextDx, size.height)
        //     ..lineTo(_nextDx, _nextDy),
        //   shadowLine2,
        // );
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
  bool shouldRepaint(DrawGraph oldDelegate) => oldDelegate.tapped != tapped || oldDelegate.entries != entries;
}
