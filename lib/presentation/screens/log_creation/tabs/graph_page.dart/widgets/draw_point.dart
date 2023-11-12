// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workout_notes_app/theme/app_theme.dart';

// class GraphPoint extends StatelessWidget {
//   const GraphPoint({Key? key, required this.entry}) : super(key: key);

//   final GraphModel entry;

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: MediaQuery.of(context).size,
//       painter: DrawPoint(
//         pointPosition: entry,
//         color: AppTheme.of(context).accentPositive,
//         topGradientColor: AppTheme.of(context).accentPositive.withOpacity(0.5),
//         bottomGradientColor:
//             AppTheme.of(context).accentNegative.withOpacity(0.5),
//       ),
//     );
//   }
// }

// class DrawPoint extends CustomPainter {
//   const DrawPoint({
//     Key? key,
//     required this.pointPosition,
//     required this.color,
//     required this.topGradientColor,
//     required this.bottomGradientColor,
//   });

//   final GraphModel pointPosition;
//   final Color color;
//   final Color topGradientColor;
//   final Color bottomGradientColor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final gradient = LinearGradient(
//       colors: [topGradientColor, bottomGradientColor],
//       stops: [0.2, 0.99],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     );
//     Paint shadowLine2 = Paint()
//       ..shader =
//           gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     Paint points = Paint()
//       ..color = color
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 12;

//     //var _dx = pointPosition.x * size.width;
//     // var _nextDx = pointPosition.nextX * size.width;
//     //var _distance = (_nextDx - _dx) / 2;
//     /* canvas.drawPath(
//       Path()
//         ..moveTo(_dx - _distance, 0)
//         ..lineTo(_dx - _distance, size.height)
//         ..lineTo(_nextDx - _distance, size.height)
//         ..lineTo(_nextDx - _distance, 0),
//       shadowLine2,
//     ); */
//     canvas.drawLine(Offset((pointPosition.x * size.width), 0),
//         Offset(pointPosition.x * size.width, size.height), shadowLine2);
//     canvas.drawLine(
//         Offset((pointPosition.x * size.width), pointPosition.y * size.height),
//         Offset(pointPosition.x * size.width, pointPosition.y * size.height),
//         points);
//   }

//   @override
//   bool shouldRepaint(DrawPoint oldDelegate) =>
//       oldDelegate.pointPosition != pointPosition;
// }
