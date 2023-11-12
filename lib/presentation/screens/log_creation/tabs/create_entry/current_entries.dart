import 'package:flutter/material.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

typedef void VoidLogCallback(WorkoutLogViewModel? log);

class CurrentEntries extends StatefulWidget {
  const CurrentEntries({
    Key? key,
    required this.currentEntries,
    required this.onLongPressed,
  }) : super(key: key);

  final List<WorkoutLogViewModel> currentEntries;
  final VoidLogCallback onLongPressed;

  @override
  State<CurrentEntries> createState() => _CurrentEntriesState();
}

class _CurrentEntriesState extends State<CurrentEntries> {
  WorkoutLogViewModel? _selectedLog;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          itemCount: widget.currentEntries.length,
          itemBuilder: (BuildContext context, index) {
            return _EntryRow(
              setCount: index + 1,
              onLongPressed: () {
                setState(() {
                  if (_selectedLog != widget.currentEntries[index]) {
                    _selectedLog = widget.currentEntries[index];
                    widget.onLongPressed(_selectedLog);
                  } else {
                    _selectedLog = null;
                    widget.onLongPressed(_selectedLog);
                  }
                });
              },
              entry: widget.currentEntries[index],
              selectedEntry: _selectedLog,
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

  final WorkoutLogViewModel? entry;
  final VoidCallback? onLongPressed;
  final int? setCount;
  final WorkoutLogViewModel? selectedEntry;

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
                    text: entry?.workoutLog.weight.toString() ?? 'WEIGHT',
                  ),
                  _Field(
                    text: entry?.workoutLog.reps.toString() ?? 'REPS',
                  ),
                  _Field(
                    text: entry?.workoutLog.exerciseRPE.toString() ?? 'RPE',
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
