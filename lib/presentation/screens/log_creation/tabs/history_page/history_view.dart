// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_notes_app/data_models/exercise_log.dart';
// import 'package:workout_notes_app/data_models/group_by_model.dart';
// import 'package:workout_notes_app/provider/day_selector_provider.dart';
// import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/history_page/history_table.dart';
// import 'package:workout_notes_app/services/providers.dart';
// import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

// final entriesHistoryByExerciseStreamProvider =
//     StreamProvider.autoDispose<List<GroupByModel<ExerciseLog>>>((ref) {
//   final database = ref.watch(databaseProvider);
//   final date = ref.watch(selectedDateProvider);
//   final selectedExercise = ref.watch(addExerciseLogProvider).selectedExercise;
//   final vm = EntriesViewModel(
//     database: database,
//     toDate: date.daySelected,
//     byExerciseID: selectedExercise.id,
//   );
//   return vm.entriesHistoryByExerciseStream;
// });

// class HistoryView extends ConsumerWidget {
//   final List<ExerciseLog> exerciseLog;
//   HistoryView({
//     Key? key,
//     required this.exerciseLog,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _historyStream = watch(entriesHistoryByExerciseStreamProvider);

//     if (exerciseLog.isEmpty) {
//       return Center(
//         child: Text(
//           "EMPTY LOG",
//           style: Theme.of(context).textTheme.headline2,
//         ),
//       );
//     }

//     return _historyStream.when(
//       data: (List<GroupByModel<ExerciseLog>> data) => ListView(
//         children: [
//           HistoryTable(model: data.reversed.toList()),
//         ],
//       ),
//       error: (error, __) => Text(error.toString()),
//       loading: () => CenterProgressIndicator(),
//     );
//   }
// }

// /* class _DateTitle extends StatelessWidget {
//   final String date;

//   const _DateTitle({Key? key, required this.date}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 40,
//         decoration: BoxDecoration(
//           color: AppTheme.of(context).primary,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(
//               date,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// } */

// /* class _Table extends StatelessWidget {
//   final String weightField;
//   final String repsField;
//   final String rpe;

//   const _Table(
//       {Key? key,
//       required this.weightField,
//       required this.repsField,
//       required this.rpe})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Text(
//           "WEIGHT: $weightField",
//           style: Theme.of(context).textTheme.caption,
//         ),
//         Text(
//           "REPS: $repsField",
//           style: Theme.of(context).textTheme.caption,
//         ),
//         Text(
//           "RPE: $rpe",
//           style: Theme.of(context).textTheme.caption,
//         ),
//       ],
//     );
//   }
// }


//  */







// /* GroupedListView<ExerciseLog, String>(
//       groupBy: (element) => element.dateCreated,
//       elements: exerciseLog,
//       order: GroupedListOrder.DESC,
//       groupSeparatorBuilder: (value) {
//         var dateGroupBy = DateTime.parse(value);
//         return _DateTitle(
//           date: DateFormat("yMMMMEEEEd").format(dateGroupBy).toString(),
//         );
//       },
//       indexedItemBuilder: (context, exerciseLogModel, index) {
//         return _Table(
//           weightField: exerciseLogModel.weight.toString(),
//           repsField: exerciseLogModel.reps.toString(),
//           rpe: exerciseLogModel.exerciseRPE.toString(),
//         );
//       },
//     ); */