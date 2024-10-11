part of 'exercise_selector_bloc.dart';

typedef ExerciseSelectorState = AsyncState<List<Exercise>>;
typedef InitialExerciseSelectorState = Initial<List<Exercise>>;
typedef LoadingExerciseSelectorState = Loading<List<Exercise>>;
typedef DataExerciseSelectorState = Loaded<List<Exercise>>;
typedef ErrorExerciseSelectorState = Error<List<Exercise>>;
