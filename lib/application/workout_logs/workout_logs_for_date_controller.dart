import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/selected_date/selected_date_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/global/extensions/date_time.dart';

final workoutLogForDateProvider = StreamNotifierProvider<WorkoutLogForDateController, List<WorkoutLogViewModel>>(
  WorkoutLogForDateController.new,
);

class WorkoutLogForDateController extends StreamNotifier<List<WorkoutLogViewModel>> {
  WorkoutLogForDateController();

  @override
  Stream<List<WorkoutLogViewModel>> build() async* {
    final selectedDate = ref.watch(selectedDateProvider);
    final logs = ref.watch(workoutLogProvider);

    if (!logs.hasValue) {
      yield [];
    }

    yield logs.value!.where((element) => DateTime.parse(element.workoutLog.dateCreated).isEqual(selectedDate)).toList();
  }
}
