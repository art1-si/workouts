import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/global/extensions/date_time.dart';

final workoutLogsEventPeakForDateProvider =
    AsyncNotifierProvider.family<WorkoutLogsEventPeakForDateNotifier, bool, DateTime>(
  WorkoutLogsEventPeakForDateNotifier.new,
);

class WorkoutLogsEventPeakForDateNotifier extends FamilyAsyncNotifier<bool, DateTime> {
  @override
  FutureOr<bool> build(DateTime arg) async {
    final workoutLogs = await ref.watch(workoutLogControllerProvider.future);
    return workoutLogs.any((element) => element.dateCreated.isEqual(arg));
  }
}
