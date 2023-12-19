import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/application/exercises/combine_exercises_controller.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/global/extensions/string_extensions.dart';
import 'package:workouts/presentation/navigation/screens.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class ExerciseSelectorScreen extends ConsumerWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsyncValue = ref.watch(combineExercisesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          exercisesAsyncValue.when(
            data: (data) => IconButton(
              onPressed: () => context.pushNamed(Screens.exerciseCreation.named, extra: data),
              icon: const Icon(Icons.add),
            ),
            loading: () => const SizedBox(),
            error: (error, stackTrace) => const SizedBox(),
          ),
        ],
        elevation: 0,
        title: const Text('Select Exercises'),
      ),
      body: exercisesAsyncValue.when(
        data: (data) => ExerciseSelectorList(exercises: data),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
      ),
    );
  }
}

class ExerciseSelectorList extends StatefulWidget {
  const ExerciseSelectorList({
    super.key,
    required this.exercises,
  });

  final List<Exercise> exercises;

  @override
  State<ExerciseSelectorList> createState() => _ExerciseSelectorListState();
}

class _ExerciseSelectorListState extends State<ExerciseSelectorList> {
  Map<String, List<Exercise>> get groupedExercisesByType {
    return groupBy(widget.exercises, (exercise) => exercise.exerciseType.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: groupedExercisesByType.keys.length,
      itemBuilder: (context, index) {
        final exerciseType = groupedExercisesByType.keys.elementAt(index);
        return ExpandableExerciseTypeTile(
          exerciseType: exerciseType,
          exercises: groupedExercisesByType[exerciseType]!,
        );
      },
    );
  }
}

class ExpandableExerciseTypeTile extends StatefulWidget {
  const ExpandableExerciseTypeTile({
    super.key,
    required this.exerciseType,
    required this.exercises,
  });

  final String exerciseType;
  final List<Exercise> exercises;

  @override
  State<ExpandableExerciseTypeTile> createState() => _ExpandableExerciseTypeTileState();
}

class _ExpandableExerciseTypeTileState extends State<ExpandableExerciseTypeTile> {
  final duration = const Duration(milliseconds: 250);

  static const _typeTileHeight = 56.0;
  static const _exerciseTileHeight = 45.0;

  bool _expanded = false;

  Widget get _exerciseTypeTile {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () => setState(() {
        _expanded = !_expanded;
      }),
      title: StyledText.body(
        widget.exerciseType.capitalize,
      ),
    );
  }

  Widget get _expandedExerciseTypeTile {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _exerciseTypeTile,
        _exercisesList,
      ],
    );
  }

  Widget get _exercisesList {
    return Column(
      children: widget.exercises
          .mapIndexed(
            (index, e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () => context.pushNamed(Screens.logCreation.named,
                    extra: {'exercises': widget.exercises, 'indexOfSelectedExercise': index}),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: _exerciseTileHeight,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: StyledText.body(
                        e.exerciseName,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = (widget.exercises.length * _exerciseTileHeight) + _typeTileHeight + 8;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          // color: AppColors.primaryShades.shade90,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryShades.shade90,
            width: 2,
          ),
        ),
        height: _expanded ? expandedHeight : _typeTileHeight,
        duration: duration,
        child: _expanded ? _expandedExerciseTypeTile : _exerciseTypeTile,
      ),
    );
  }
}
