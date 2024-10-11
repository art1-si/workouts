import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts/configuration/god_mode_mixin.dart';
import 'package:workouts/dev_tools/logger/log_tag.dart';
import 'package:workouts/dev_tools/logger/logger.dart';
import 'package:workouts/domain/entities/exercise.dart';
import 'package:workouts/domain/exceptions/shared_exceptions.dart';
import 'package:workouts/domain/use_cases/get_all_available_exercises.dart';
import 'package:workouts/presentation/shared/async_state/async_state.dart';

part 'exercise_selector_event.dart';
part 'exercise_selector_state.dart';

class ExerciseSelectorBloc extends Bloc<ExerciseSelectorEvent, ExerciseSelectorState> with GodModeMixin {
  ExerciseSelectorBloc({required GetAllAvailableExercises getAllAvailableExercises})
      : _getAllAvailableExercises = getAllAvailableExercises,
        super(const InitialExerciseSelectorState()) {
    on<GetAllAvailableExercisesEvent>(_onGetAllAvailableExercises);
  }

  final GetAllAvailableExercises _getAllAvailableExercises;

  Future<void> _onGetAllAvailableExercises(
      GetAllAvailableExercisesEvent event, Emitter<ExerciseSelectorState> emit) async {
    emit(const LoadingExerciseSelectorState());
    try {
      final result = await _getAllAvailableExercises.execute();
      emit(Loaded(result));
    } catch (e, st) {
      Logger.error(e.toString(), st, LogTag.exerciseSelector);
      emit(Error(_createMessageFromError(e)));
    }
  }

  String _createMessageFromError(Object error) {
    return switch (error) {
      NoInternetException() => 'Something went wrong. Please check your internet connection.',
      GenericException() => 'Something went wrong. Please try again later.${godMode ? '\nError: $error' : ''}',
      Object() =>
        'Something went wrong. Please try again later.${godMode ? '\nVERY BAD UNEXPECTED ERROR!!!\nError: $error' : ''}',
    };
  }
}
