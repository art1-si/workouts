import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/theme/typography.dart';

typedef ExerciseLogSet = Map<String, List<WorkoutLogViewModel>>;

class LogOverviewCard extends StatelessWidget {
  const LogOverviewCard({super.key, required this.workoutLog});

  final WorkoutLogViewModel workoutLog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText.body(workoutLog.exercise.exerciseName),
          LoggedSetsTable(
            exerciseSets: workoutLog.workoutLog,
          )
        ],
      ),
    );
  }
}

class LoggedSetsTable extends StatelessWidget {
  const LoggedSetsTable({super.key, required this.exerciseSets});

  final List<WorkoutLog> exerciseSets;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            StyledText.body(''),
            StyledText.body('REPS'),
            StyledText.body('WEIGHT'),
            StyledText.body('1RM'),
          ],
        ),
        ...exerciseSets.mapIndexed((index, e) => TableRow(children: [
              StyledText.body('SET ${index + 1}'),
              StyledText.body(e.reps.toString()),
              StyledText.body(e.weight.toString()),
              StyledText.body(e.exerciseRPE.toString()),
            ])),
      ],
    );
  }
}
