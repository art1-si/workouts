// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workouts/global/extensions/date_time.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/services/details_provider.dart';
// import 'package:workouts/presentation/theme/app_colors.dart';

// class OnPressDialog extends ConsumerWidget {
//   OnPressDialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final details = ref.watch(detailsProvider);

//     if (details.logDetails != null) {
//       final _date = details.logDetails!.correspondingLog.dateCreated;
//       final _formateDate = _date.toPMTViewFormatShort();
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.primaryShades.shade80,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: _PopUpTable(
//             rpeCount: details.logDetails!.correspondingLog.exerciseRPE,
//             field1: 'WEIGHT ${details.logDetails!.correspondingLog.weight}',
//             field2: '${details.logDetails!.correspondingLog.reps}',
//             field4: 'Date: $_formateDate',
//             field3: details.pointedValue() == null ? null : details.pointedValue().toString(),
//           ),
//         ),
//       );
//     }
//     return Container();
//   }
// }

// class _PopUpTable extends StatelessWidget {
//   const _PopUpTable({
//     Key? key,
//     required this.field1,
//     required this.field2,
//     required this.field3,
//     required this.field4,
//     required this.rpeCount,
//   }) : super(key: key);

//   final String field1;
//   final String field2;
//   final String? field3;
//   final String field4;
//   final int rpeCount;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Container(
//         height: 70,
//         child: Stack(
//           children: [
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 350),
//               width: field3 == null ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * (3 / 5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       '$field1 x $field2',
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'RPE:',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         Text(
//                           '$rpeCount',
//                           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AnimatedAlign(
//               alignment: field3 == null ? Alignment.bottomRight : Alignment.bottomLeft,
//               duration: const Duration(milliseconds: 350),
//               curve: Curves.easeInOutCubic,
//               child: Text(
//                 field4,
//                 style: Theme.of(context).textTheme.overline,
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: AnimatedOpacity(
//                 duration: const Duration(milliseconds: 350),
//                 opacity: field3 != null ? 1 : 0.0,
//                 curve: Curves.easeInOutCubic,
//                 child: SizedBox(
//                   width: 100,
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: VerticalDivider(
//                           color: AppColors.primaryShades.shade70,
//                           thickness: 2,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               'VALUE:',
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                             Text(
//                               field3 == null ? '0.0' : field3!,
//                               style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white54),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
