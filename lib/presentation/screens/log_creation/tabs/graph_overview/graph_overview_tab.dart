import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/graph_date_filter/graph_date_filter_notifier.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/services/graph_selector_provider.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/log_graph.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

import 'package:workouts/presentation/theme/typography.dart';

class GraphOverviewTab extends ConsumerWidget {
  final List<WorkoutLog> workoutLogs;
  GraphOverviewTab({
    Key? key,
    required this.workoutLogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphFilterDate = ref.watch(graphDateFilterNotifierProvider);
    final filteredLogs = workoutLogs.where((log) {
      if (graphFilterDate == null) {
        return true;
      }

      return log.dateCreated.isAfter(graphFilterDate);
    }).toList();
    if (workoutLogs.isEmpty) {
      return Center(
        child: StyledText.headline('EMPTY LOG'),
      );
    }

    return Container(
        color: AppColors.primaryShades.shade110,
        child: ListView(
          children: [
            const GraphDateFilterSelector(),
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                key: ValueKey(filteredLogs),
                workoutLogs: filteredLogs,
                graphProperties: GraphProperties.oneRepMax,
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                key: ValueKey(filteredLogs),
                workoutLogs: filteredLogs,
                graphProperties: GraphProperties.perWeight,
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: WorkoutOverviewGraph(
                key: ValueKey(filteredLogs),
                workoutLogs: filteredLogs,
                graphProperties: GraphProperties.simpleVolumePerSet,
              ),
            ),
          ],
        ));
  }
}

class GraphDateFilterSelector extends ConsumerWidget {
  const GraphDateFilterSelector({super.key});

  DateTime get now => DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphFilterDate = ref.watch(graphDateFilterNotifierProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        color: AppColors.primaryShades.shade100,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: graphFilterDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  ref.read(graphDateFilterNotifierProvider.notifier).set(date);
                }
                ref.read(graphDateFilterNotifierProvider.notifier).set(date);
              },
              child: StyledText.button(graphFilterDate?.toPMTViewFormatShort() ?? 'CUSTOM'),
            ),
            TextButton(
              onPressed: () {
                ref.read(graphDateFilterNotifierProvider.notifier).set(null);
              },
              child: Text('ALL', style: TextStyle(color: graphFilterDate == null ? Colors.white : Colors.white30)),
            ),
          ],
        ),
      ),
    );
  }
}
