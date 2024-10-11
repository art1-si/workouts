import 'workout_log_view_model.dart';
import '../../../../lib/presentation/features/calendar/extension/date_time.dart';

extension WorkoutLogsForDate on WorkoutLogViewModel {
  WorkoutLogViewModel workoutLogsForDate(DateTime date) {
    final workoutLogsForDate = workoutLog.where((element) => element.dateCreated.isEqual(date)).toList();
    return WorkoutLogViewModel(
      exercise: exercise,
      workoutLog: workoutLogsForDate,
    );
  }
}
