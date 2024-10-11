part of 'exercise_selector_bloc.dart';

sealed class ExerciseSelectorEvent {
  const ExerciseSelectorEvent();
}

class GetAllAvailableExercisesEvent extends ExerciseSelectorEvent {
  const GetAllAvailableExercisesEvent();
}
