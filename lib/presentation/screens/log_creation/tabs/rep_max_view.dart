import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/presentation/theme/typography.dart';

double roundDouble(double value, int places) {
  final mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

double epleyCalOneRepMax(double weight, int reps) {
  var oneRepMax = weight * (1 + reps / 30);
  return roundDouble(oneRepMax, 1);
}

class RepMaxView extends StatelessWidget {
  RepMaxView({Key? key, required this.exerciseLog}) : super(key: key);
  final List<int> oneRMPercents = [110, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 5, 1];
  final WorkoutLogViewModel exerciseLog;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StyledText.headline1(
        'EMPTY LOG',
      ),
    );

    // var lastElementFromSnapshot = exerciseLog.last;
    // var oneRepMax =
    //     epleyCalOneRepMax(lastElementFromSnapshot.workoutLog.weight, lastElementFromSnapshot.workoutLog.reps);
    // return Center(
    //   child: ListView.builder(
    //     itemCount: oneRMPercents.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           height: 30,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: <Widget>[
    //               Container(
    //                 width: 100,
    //                 child: Center(
    //                   child: Text(
    //                     '${oneRMPercents[index]}%',
    //                     style: Theme.of(context).textTheme.headline4,
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 width: 100,
    //                 child: const Center(
    //                   child: Text(
    //                     'of 1RM',
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 width: 100,
    //                 child: Center(
    //                   child: Text(
    //                     '${oneRepMax * (oneRMPercents[index] ~/ 100)}',
    //                     style: Theme.of(context).textTheme.headline4,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
