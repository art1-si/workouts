import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class LogOverviewCard extends StatelessWidget {
  const LogOverviewCard({
    super.key,
    required this.workoutLog,
    required this.onTap,
    required this.title,
    this.backgroundColor,
  });
  final String title;
  final List<WorkoutLog> workoutLog;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.primaryShades.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: StyledText.labelSmall(
                    title.toUpperCase(),
                    bold: true,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: LoggedSetsTable(
                    exerciseSets: workoutLog,
                  ),
                ),
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          const Row(
            children: [
              _KeyCell('', flex: 1),
              _KeyCell('REPS', flex: 1),
              _KeyCell('WEIGHT', flex: 1),
              _KeyCell('1RM', flex: 1),
            ],
          ),
          ...exerciseSets.mapIndexed((index, e) => Row(children: [
                _KeyCell('SET ${index + 1}', flex: 1, alignment: Alignment.centerRight),
                _ValueCell(e.reps.toString(), flex: 1),
                _ValueCell(e.weight.toString(), flex: 1),
                _ValueCell(e.exerciseRPE.toString(), flex: 1),
              ])),
        ],
      ),
    );
  }
}

class _KeyCell extends StatelessWidget {
  const _KeyCell(this.value, {required this.flex, this.alignment = Alignment.center});

  final String value;
  final int flex;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: alignment,
          child: StyledText.labelSmall(
            value,
            color: AppColors.primaryShades.shade80,
          ),
        ),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell(this.value, {required this.flex});

  final String value;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Center(child: StyledText.labelMedium(value)),
      ),
    );
  }
}
