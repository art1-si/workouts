// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workouts/data/workout_logs/models/workout_log.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/widgets/graph.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/widgets/onPressDialog.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/widgets/proerties_drop_down_menu.dart';

// class MyGraphWidget extends StatelessWidget {
//   final List<WorkoutLog> exerciseLog;
//   MyGraphWidget({
//     Key? key,
//     required this.exerciseLog,
//   }) : super(key: key);

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     if (exerciseLog.isEmpty) {
//       return Center(
//         child: Text(
//           'EMPTY LOG',
//           style: Theme.of(context).textTheme.headline2,
//         ),
//       );
//     }

//     return const _BodyContent();
//   }
// }

// class _BodyContent extends ConsumerWidget {
//   const _BodyContent({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListView(
//       children: [
//         const PropertiesDropDown(),
//         OnPressDialog(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//           child: AspectRatio(
//             aspectRatio: 1.0,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 bottom: 16,
//                 left: 4,
//                 right: 0.0,
//                 top: 16,
//               ),
//               child: MyDrawGraph(
//                 //TODO(Artur):Implement graph data
//                 chartData: [],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
