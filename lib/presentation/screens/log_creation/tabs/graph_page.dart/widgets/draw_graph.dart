// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workout_notes_app/theme/app_theme.dart';

// class LinerGraph extends StatelessWidget {
//   const LinerGraph({
//     Key? key,
//     required this.exerciseLog,
//     required this.isPressed,
//   }) : super(key: key);

//   final List<GraphModel> exerciseLog;
//   final bool isPressed;

//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);

//     return RepaintBoundary(
//       child: CustomPaint(
//         size: MediaQuery.of(context).size,
//         painter: DrawGraph(
//           tapped: isPressed,
//           entries: exerciseLog,
//           lineColor: theme.accentSecendery,
//           tappedLineColor: theme.accentPositive,
//           topGradientColor: theme.accentSecendery.withOpacity(0.1),
//           bottomGradientColor: theme.accentNegative.withOpacity(0.07),
//           tappedBottomGradientColor: theme.accentNegative.withOpacity(0.07),
//           tappedTopGradientColor: theme.accentPositive.withOpacity(0.1),
//         ),
//       ),
//     );
//   }
// }

// class DrawGraph extends CustomPainter {
//   const DrawGraph({
//     Key? key,
//     required this.topGradientColor,
//     required this.bottomGradientColor,
//     required this.tappedTopGradientColor,
//     required this.tappedBottomGradientColor,
//     required this.entries,
//     required this.lineColor,
//     required this.tappedLineColor,
//     required this.tapped,
//   });

//   final List<GraphModel> entries;
//   final bool tapped;
//   final Color lineColor;
//   final Color tappedLineColor;
//   final Color topGradientColor;
//   final Color bottomGradientColor;
//   final Color tappedTopGradientColor;
//   final Color tappedBottomGradientColor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Color gradinetColorStarter =
//         (!tapped) ? topGradientColor : tappedTopGradientColor;
//     Color endGradinetColor =
//         (!tapped) ? bottomGradientColor : tappedBottomGradientColor;
//     final gradient = LinearGradient(
//       colors: [gradinetColorStarter, endGradinetColor],
//       stops: [0.6, 0.99],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     );
//     Paint shadowLine2 = Paint()
//       ..shader =
//           gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 2;

//     Paint line2 = Paint()
//       ..color = (!tapped) ? lineColor : tappedLineColor
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     if (entries.length > 1) {
//       entries.forEach((element) {
//         double _dx = element.x * size.width;
//         double _dy = element.y * size.height;
//         double _nextDx = element.nextX * size.width;
//         double _nextDy = element.nextY * size.height;
//         //Draw main line

//         canvas.drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);

//         //Draw background
//         canvas.drawPath(
//           Path()
//             ..moveTo(_dx, _dy)
//             ..lineTo(_dx, size.height)
//             ..lineTo(_nextDx, size.height)
//             ..lineTo(_nextDx, _nextDy),
//           shadowLine2,
//         );
//       });
//     } else {
//       double _dx = 0;
//       double _dy = size.height / 2;
//       double _nextDx = size.width;
//       double _nextDy = size.height / 2;
//       //Draw main line

//       canvas.drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);

//       //Draw background
//       canvas.drawPath(
//         Path()
//           ..moveTo(_dx, _dy)
//           ..lineTo(_dx, size.height)
//           ..lineTo(_nextDx, size.height)
//           ..lineTo(_nextDx, _nextDy),
//         shadowLine2,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(DrawGraph oldDelegate) =>
//       oldDelegate.tapped != tapped || oldDelegate.entries != entries;
// }
