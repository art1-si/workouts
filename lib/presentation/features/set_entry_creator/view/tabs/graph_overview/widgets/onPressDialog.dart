import 'package:flutter/material.dart';
import '../../../../../../../../lib.old/data/workout_logs/models/workout_log.dart';
import '../../../../../../../../lib.old/global/extensions/date_time.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../theme/typography.dart';

class OnPressDialog extends StatelessWidget {
  OnPressDialog({
    Key? key,
    required this.log,
    required this.valueBuilder,
  }) : super(key: key);

  final WorkoutLog? log;
  final double Function(WorkoutLog log) valueBuilder;

  @override
  Widget build(BuildContext context) {
    if (log != null) {
      final _date = log!.dateCreated;
      final _formateDate = _date.toWorkoutsViewFormat();
      return _PopUpTable(
        rpeCount: log!.exerciseRPE,
        field1: '${log!.weight}',
        field2: '${log!.reps}',
        field4: 'Date: $_formateDate',
        field3: valueBuilder(log!).toString(),
      );
    }
    return Container();
  }
}

class _PopUpTable extends StatelessWidget {
  const _PopUpTable({
    Key? key,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
    required this.rpeCount,
  }) : super(key: key);

  final String field1;
  final String field2;
  final String? field3;
  final String field4;
  final int rpeCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: StyledText.labelSmall(
                        'WEIGHT X REPS:',
                        color: AppColors.primaryShades.shade80,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: StyledText.headline2(
                        '$field1 x $field2',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StyledText.labelSmall(
                        'RPE:',
                        color: AppColors.primaryShades.shade80,
                      ),
                      StyledText.headline2(
                        '$rpeCount',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StyledText.labelSmall(
                        'VALUE:',
                        color: AppColors.primaryShades.shade80,
                      ),
                      StyledText.headline2(
                        field3 == null ? '0.0' : field3!,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomLeft,
            child: StyledText.labelSemiMedium(
              field4,
              color: AppColors.primaryShades.shade80,
            ),
          ),
        ],
      ),
    );
  }
}
