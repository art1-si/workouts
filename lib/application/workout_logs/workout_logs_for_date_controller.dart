import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/global/extensions/date_time.dart';

final workoutLogForDateProvider =
    StreamNotifierProvider.family<WorkoutLogForDateController, List<WorkoutLog>, DateTime>(
  WorkoutLogForDateController.new,
);

class WorkoutLogForDateController extends FamilyStreamNotifier<List<WorkoutLog>, DateTime> {
  WorkoutLogForDateController();

  @override
  Stream<List<WorkoutLog>> build(DateTime date) async* {
    final logs = await ref.watch(workoutLogProvider.future);

    yield logs.where((element) => DateTime.parse(element.dateCreated).isEqual(date)).toList();
  }
}
