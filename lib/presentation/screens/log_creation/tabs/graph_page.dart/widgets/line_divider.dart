// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/chart_provider.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'dart:ui' as ui;

// import 'package:workout_notes_app/services/logics.dart';
// import 'package:workout_notes_app/theme/app_theme.dart';

// class LineDividers extends ConsumerWidget {
//   const LineDividers({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   final List<GraphModel> data;

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _chartProvider = watch(chartViewProvider);
//     final _distance = data.first.nextX - data.first.x;
//     return RepaintBoundary(
//       child: CustomPaint(
//         painter: _DrawLines(
//           dividerColor: AppTheme.of(context).divider,
//           distance: _distance,
//           highestValue: _chartProvider.maxValue,
//           lowestValue: _chartProvider.minValue,
//         ),
//         size: Size(
//           MediaQuery.of(context).size.width,
//           MediaQuery.of(context).size.height,
//         ),
//       ),
//     );
//   }
// }

// class _DrawLines extends CustomPainter {
//   _DrawLines({
//     required this.lowestValue,
//     required this.highestValue,
//     required this.dividerColor,
//     required this.distance,
//   });
//   final double distance;
//   final double? lowestValue;
//   final double highestValue;
//   final Color dividerColor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     createdWeightParagraph(Canvas canvas, paragraphXoffset, text) {
//       final textStyle = ui.TextStyle(
//         color: Colors.white54,
//         fontSize: 10,
//         letterSpacing: 1.5,
//       );
//       final paragraphStyle = ui.ParagraphStyle(
//         textDirection: TextDirection.ltr,
//       );
//       final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
//         ..pushStyle(textStyle)
//         ..addText('$text');
//       final constraints = ui.ParagraphConstraints(width: 50);
//       final paragraph = paragraphBuilder.build();
//       paragraph.layout(constraints);
//       return canvas.drawParagraph(paragraph, Offset(0, paragraphXoffset));
//     }

//     Paint dividerLine = Paint()
//       ..color = dividerColor
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 0.5;
//     if (lowestValue != null && lowestValue != highestValue) {
//       var weightValue = lowestValue;
//       for (var i = 0; i < 11; i++) {
//         double weightGraphValue = roundDouble(weightValue!, 2);
//         double relativeYposition =
//             (weightGraphValue - lowestValue!) / (highestValue - lowestValue!);
//         double yOffset = size.height - relativeYposition * size.height;

//         canvas.drawLine(
//             Offset(0, yOffset), Offset(size.width, yOffset), dividerLine);

//         createdWeightParagraph(canvas, yOffset - 12, weightGraphValue);

//         weightValue += (highestValue - lowestValue!) / 10;
//       }
//     } else {
//       createdWeightParagraph(canvas, size.height / 2, highestValue);

//       canvas.drawLine(Offset(0, size.height / 2),
//           Offset(size.width, size.height / 2), dividerLine);
//     }
//     var gridGap = size.width / 12;
//     var _distanceToSize = (distance) * size.width;
//     double _corespondingGap = _distanceToSize;
//     while (_corespondingGap < gridGap) {
//       _corespondingGap = _corespondingGap + _distanceToSize;
//     }
//     var gap = 0.07 * size.width; //*may couse bugs in graph layout part 2
//     for (var i = 0; i < 12; i++) {
//       canvas.drawLine(
//           Offset(gap, -10), Offset(gap, size.height + 10), dividerLine);
//       gap = gap + _corespondingGap;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _DrawLines oldDelegate) {
//     return oldDelegate.highestValue != highestValue ||
//         oldDelegate.lowestValue != lowestValue;
//   }
// }
