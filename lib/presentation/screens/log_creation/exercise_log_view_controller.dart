import 'package:flutter/material.dart';
import 'package:workouts/data/exercises/model/exercise.dart';

class WorkoutLogViewController extends ValueNotifier<Exercise> {
  WorkoutLogViewController(this.exercises, int selectedIndex) : super(exercises[selectedIndex]);
  int get selectedIndex => exercises.indexOf(value);
  final List<Exercise> exercises;

  bool get canGoToNext => selectedIndex < exercises.length - 1;
  bool get canGoToPrevious => selectedIndex > 0;

  void goToNext() {
    if (canGoToNext) value = exercises[selectedIndex + 1];
  }

  void goToPrevious() {
    if (canGoToPrevious) value = exercises[selectedIndex - 1];
  }
}
