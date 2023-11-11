import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/global/extensions/date_time.dart';

final workoutLogForDateProvider =
    StreamNotifierProvider.family<WorkoutLogForDateController, List<WorkoutLogViewModel>, DateTime>(
  WorkoutLogForDateController.new,
);

class WorkoutLogForDateController extends FamilyStreamNotifier<List<WorkoutLogViewModel>, DateTime> {
  WorkoutLogForDateController();

  @override
  Stream<List<WorkoutLogViewModel>> build(DateTime date) async* {
    final logs = ref.watch(workoutLogProvider);
    print('logs: $logs');

    if (!logs.hasValue) {
      yield [];
    }

    yield logs.value!.where((element) => DateTime.parse(element.workoutLog.dateCreated).isEqual(date)).toList();
  }
}
