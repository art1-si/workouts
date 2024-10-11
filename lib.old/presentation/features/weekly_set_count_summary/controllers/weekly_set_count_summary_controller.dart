import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/exercises/combine_exercises_controller.dart';
import '../../../../application/workout_logs/workout_logs_controller.dart';
import '../../../../../lib/domain/entities/exercise.dart';
import '../../../../../lib/presentation/features/calendar/extension/date_time.dart';
import '../../../../../lib/presentation/features/calendar/model/week_number.dart';
import '../models/exercise_type_set_summary.dart';

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
