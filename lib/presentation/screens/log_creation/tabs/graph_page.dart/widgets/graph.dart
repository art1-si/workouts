// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/chart_provider.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_provider.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_selector_provider.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_point.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/line_divider.dart';

// class MyDrawGraph extends StatelessWidget {
//   MyDrawGraph({Key? key, required this.chartData}) : super(key: key);
//   final List<GraphModel> chartData;

//   @override
//   Widget build(BuildContext context) {
//     var _width = MediaQuery.of(context).size.width;

//     return GestureDetector(
//       onPanDown: (details) {
//         context.read(chartProvider).handleGraphPressed();
//         var _res = Offset(
//             details.globalPosition.dx / _width, details.globalPosition.dy);
//         context.read(detailsProvider).setOffset(_res);
//       },
//       onPanStart: (details) {
//         var _res = Offset(
//             details.globalPosition.dx / _width, details.globalPosition.dy);
//         context.read(detailsProvider).setOffset(_res);
//       },
//       onPanUpdate: (details) {
//         var _res = Offset(
//             details.globalPosition.dx / _width, details.globalPosition.dy);
//         context.read(detailsProvider).setOffset(_res);
//       },
//       onPanEnd: (details) {
//         context.read(chartProvider).handleGraphPressed();
//         context.read(detailsProvider).setOffset(null);
//       },
//       onPanCancel: () {
//         context.read(chartProvider).handleGraphPressed();
//         context.read(detailsProvider).setOffset(null);
//       },
//       child: Consumer(builder: (context, watch, child) {
//         watch(graphSelector);

//         return Stack(
//           children: [
//             Consumer(
//               builder: (context, watch, child) {
//                 final provider = watch(chartProvider);
//                 final _chartProvider = watch(chartViewProvider);
//                 return LinerGraph(
//                   exerciseLog: _chartProvider.graphPoints!,
//                   isPressed: provider.showSelector,
//                 );
//               },
//             ),
//             Consumer(
//               builder: (context, watch, child) {
//                 final tappedPosition = watch(detailsProvider).index;
//                 if (tappedPosition == null) {
//                   return Container();
//                 } else {
//                   return GraphPoint(
//                     entry: chartData[tappedPosition],
//                   );
//                 }
//               },
//             ),
//             LineDividers(
//               data: chartData,
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
