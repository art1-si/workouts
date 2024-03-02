import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/exercises/combine_exercises_controller.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/global/models/week_number.dart';
import 'package:workouts/presentation/features/weekly_set_count_summary/models/exercise_type_set_summary.dart';

final weeklySetCountSummaryControllerProvider =
    AsyncNotifierProviderFamily<WeeklySetCountSummaryController, List<ExerciseTypeSetSummary>, WeekNumber>(
  WeeklySetCountSummaryController.new,
);

class WeeklySetCountSummaryController extends FamilyAsyncNotifier<List<ExerciseTypeSetSummary>, WeekNumber> {
  List<ExerciseTypeSetSummary>? _previousState;
  @override
  FutureOr<List<ExerciseTypeSetSummary>> build(WeekNumber weekNumber) async {
    if (_previousState != null) {
      state = AsyncData(_previousState!);
    }
    final logs = await ref.watch(workoutLogControllerProvider.future);
    final exercises = await ref.watch(combineExercisesControllerProvider.future);

    final logsForDate = logs
        .where((element) => element.dateCreated.isInBetween(weekNumber.firstDayOfTheWeek, weekNumber.lastDayOfTheWeek))
        .toList();

    final groupedLogs = groupBy(logsForDate, (log) => log.exerciseID);

    final summaryPerExercise = groupedLogs.keys.map((id) {
      final exercise = exercises.firstWhere(
        (element) => element.id == id,
        orElse: Exercise.unknown,
      );
      return (
        exerciseType: exercise.exerciseType,
        totalSets: groupedLogs[id]!.length,
      );
    }).toList();

    final summaryPerType = groupBy(summaryPerExercise, (summary) => summary.exerciseType);
    final summary = summaryPerType.entries.map((entry) {
      final totalSets = entry.value.fold<int>(0, (previousValue, element) => previousValue + element.totalSets);
      return ExerciseTypeSetSummary(
        exerciseType: entry.key,
        totalSets: totalSets,
      );
    }).toList();

    _previousState = summary;
    return summary;
  }
}
