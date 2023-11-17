import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class LogOverviewCard extends StatelessWidget {
  const LogOverviewCard({super.key, required this.workoutLog, required this.onTap});

  final WorkoutLogViewModel workoutLog;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledText.bodyLarge(workoutLog.exercise.exerciseName),
              const SizedBox(height: 8.0),
              LoggedSetsTable(
                exerciseSets: workoutLog.workoutLog,
              ),
              const SizedBox(height: 16.0),
              Divider(
                color: AppColors.primaryShades.shade80,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
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
        const TableRow(
          children: [
            _KeyCell(''),
            _KeyCell('REPS'),
            _KeyCell('WEIGHT'),
            _KeyCell('1RM'),
          ],
        ),
        ...exerciseSets.mapIndexed((index, e) => TableRow(children: [
              _KeyCell('SET ${index + 1}'),
              _ValueCell(e.reps.toString()),
              _ValueCell(e.weight.toString()),
              _ValueCell(e.exerciseRPE.toString()),
            ])),
      ],
    );
  }
}

class _KeyCell extends StatelessWidget {
  const _KeyCell(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(child: StyledText.labelMedium(value, color: AppColors.primaryShades.shade80)),
    );
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(child: StyledText.body(value)),
    );
  }
}