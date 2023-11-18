import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/history_page/history_table.dart';
import 'package:workouts/presentation/theme/typography.dart';

class HistoryView extends StatelessWidget {
  final List<WorkoutLog> exerciseLog;
  HistoryView({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (exerciseLog.isEmpty) {
      return Center(
        child: StyledText.headline1('EMPTY LOG'),
      );
    }

    return HistoryTable(model: exerciseLog.reversed.toList());
  }
}

/* class _DateTitle extends StatelessWidget {
  final String date;

  const _DateTitle({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              date,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );
  }
} */

/* class _Table extends StatelessWidget {
  final String weightField;
  final String repsField;
  final String rpe;

  const _Table(
      {Key? key,
      required this.weightField,
      required this.repsField,
      required this.rpe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "WEIGHT: $weightField",
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          "REPS: $repsField",
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          "RPE: $rpe",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}


 */







/* GroupedListView<ExerciseLog, String>(
      groupBy: (element) => element.dateCreated,
      elements: exerciseLog,
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (value) {
        var dateGroupBy = DateTime.parse(value);
        return _DateTitle(
          date: DateFormat("yMMMMEEEEd").format(dateGroupBy).toString(),
        );
      },
      indexedItemBuilder: (context, exerciseLogModel, index) {
        return _Table(
          weightField: exerciseLogModel.weight.toString(),
          repsField: exerciseLogModel.reps.toString(),
          rpe: exerciseLogModel.exerciseRPE.toString(),
        );
      },
    ); */