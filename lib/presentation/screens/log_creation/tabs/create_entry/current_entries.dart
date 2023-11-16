import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/new_entry_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/bottom_buttons.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

typedef void VoidLogCallback(WorkoutLog? log);

class CurrentEntries extends StatelessWidget {
  const CurrentEntries({
    Key? key,
    required this.currentEntry,
    required this.newEntryMediator,
  }) : super(key: key);

  final WorkoutLogViewModel currentEntry;
  final NewEntryMediator newEntryMediator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: newEntryMediator.editableWorkoutLog,
        builder: (context, value, child) {
          return Column(
            children: [
              RowWithBottomButtons(
                newEntryMediator: newEntryMediator,
                editModeActive: value != null,
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: _TableHeader(),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentEntry.workoutLog.length,
                itemBuilder: (BuildContext context, index) {
                  final workoutLogs = currentEntry.workoutLog;
                  return _EntryRow(
                    setCount: index + 1,
                    onLongPressed: () => newEntryMediator.toggleEditMode(workoutLogs[index]),
                    entry: workoutLogs[index],
                    selectedEntry: value,
                  );
                },
                separatorBuilder: (_, __) => Divider(
                  thickness: 1,
                  height: 1,
                  color: AppColors.primaryShades.shade90,
                ),
              ),
            ],
          );
        });
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({Key? key}) : super(key: key);
  static const TextStyle _style = TextStyle(fontSize: 10, letterSpacing: 2.0, color: Colors.white70);
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Field(
          text: 'SET',
          textStyle: _style,
        ),
        _Field(
          text: 'WEIGHT',
          textStyle: _style,
        ),
        _Field(
          text: 'REPS',
          textStyle: _style,
        ),
        _Field(
          text: 'RPE',
          textStyle: _style,
        ),
      ],
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({
    Key? key,
    this.entry,
    this.onLongPressed,
    this.selectedEntry,
    this.setCount,
  }) : super(key: key);

  final WorkoutLog? entry;
  final VoidCallback? onLongPressed;
  final int? setCount;
  final WorkoutLog? selectedEntry;

  bool get selected => selectedEntry == entry;

  bool get differentSelected => selectedEntry != null && selectedEntry != entry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLongPressed,
      child: Container(
        color: Colors.transparent,
        height: 40,
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                height: selected ? 40 : 10,
                width: selected ? MediaQuery.of(context).size.width : 10,
                decoration: BoxDecoration(
                  //TODO(Artur):User change color
                  color: selected ? AppColors.primaryShades.shade90 : null,
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              style: TextStyle(
                color: differentSelected ? Colors.white30 : Colors.white,
                fontSize: 16,
                fontWeight: selected ? FontWeight.bold : FontWeight.w400,
              ),
              duration: const Duration(milliseconds: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Field(
                    text: setCount?.toString() ?? 'SET',
                  ),
                  _Field(
                    text: entry?.weight.toString() ?? 'WEIGHT',
                  ),
                  _Field(
                    text: entry?.reps.toString() ?? 'REPS',
                  ),
                  _Field(
                    text: entry?.exerciseRPE.toString() ?? 'RPE',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Center(
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
