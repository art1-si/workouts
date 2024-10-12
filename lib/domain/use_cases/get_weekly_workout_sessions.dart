import 'package:collection/collection.dart';
import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/entities/exercise_series.dart';
import 'package:workouts/domain/entities/workout_session.dart';
import 'package:workouts/domain/extensions/date_time_extensions.dart';
import 'package:workouts/domain/repositories/exercise_repository.dart';
import 'package:workouts/domain/repositories/set_entry_repository.dart';
import 'package:workouts/domain/use_cases/use_case.dart';
import 'package:workouts/presentation/features/calendar/model/week_number.dart';

final class GetWeeklyWorkoutSessions extends UseCase<List<WorkoutSession>> {
  GetWeeklyWorkoutSessions({
    required ExerciseRepository exerciseRepository,
    required SetEntryRepository setEntryRepository,
    required this.weekNumber,
  })  : _exerciseRepository = exerciseRepository,
        _setEntryRepository = setEntryRepository;

  final ExerciseRepository _exerciseRepository;
  final SetEntryRepository _setEntryRepository;
  final WeekNumber weekNumber;
  @override
  Future<List<WorkoutSession>> execute() async {
    final exercises = await _exerciseRepository.getExercises();
    final setEntriesForWeek = await _setEntryRepository.getSetEntries(
        startDate: weekNumber.firstDayOfTheWeek, endDate: weekNumber.lastDayOfTheWeek);

    final workoutSessions = <WorkoutSession>[];
    final entriesPerDay = groupBy(setEntriesForWeek, (element) => element.dateCreated.atMidnight);

    for (final date in entriesPerDay.keys) {
      final dayEntries = entriesPerDay[date];
      final entriesPerExercise = groupBy(dayEntries!, (element) => element.exerciseId);

      final exerciseSeries = <ExerciseSeries>[];
      for (final exerciseId in entriesPerExercise.keys) {
        final exercise = exercises.firstWhere((element) => element.id == exerciseId, orElse: Exercise.unknown);
        final setEntries = entriesPerExercise[exerciseId]!;
        exerciseSeries.add(ExerciseSeries(exercise: exercise, setEntries: setEntries));
      }

      workoutSessions.add(WorkoutSession(exerciseSeries: exerciseSeries));
    }

    return workoutSessions;
  }
}
