import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/global/models/date_system.dart';
import 'package:workouts/presentation/features/weekly_set_count_summary/controllers/weekly_set_count_summary_controller.dart';
import 'package:workouts/presentation/features/weekly_set_count_summary/models/exercise_type_set_summary.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';

class WeeklySetCountSummery extends ConsumerStatefulWidget {
  const WeeklySetCountSummery({
    super.key,
    required this.calendarController,
  });

  final CalendarDatePickerController calendarController;

  @override
  ConsumerState<WeeklySetCountSummery> createState() => _WeeklySetCountSummeryState();
}

class _WeeklySetCountSummeryState extends ConsumerState<WeeklySetCountSummery> {
  late var currentPage = widget.calendarController.pageViewController.initialPage;

  void pageViewListener() {
    if (currentPage != widget.calendarController.pageViewController.pageRounded) {
      setState(() {
        currentPage = widget.calendarController.pageViewController.pageRounded;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.calendarController.pageViewController.addListener(pageViewListener);
  }

  @override
  void dispose() {
    widget.calendarController.pageViewController.removeListener(pageViewListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final displayedDate = widget.calendarController.value == CalendarViewType.monthly
        ? DateTime(now.year, now.month + currentPage, 1)
        : DateTime(now.year, now.month, now.day + (7 * currentPage));

    final displayedWeekNumber = displayedDate.weekNumber(dateSystem: DateSystem.iso);
    final weeklySetCountSummery = ref.watch(weeklySetCountSummaryControllerProvider(displayedWeekNumber));

    return weeklySetCountSummery.when(
      data: (data) {
        return WeeklySetCountSummeryGridView(exerciseTypeSetSummaries: data);
      },
      loading: () => Container(
        height: 70,
        color: AppColors.primaryShades.shade90,
        child: const Center(
          child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}

class WeeklySetCountSummeryGridView extends StatelessWidget {
  const WeeklySetCountSummeryGridView({super.key, required this.exerciseTypeSetSummaries});

  final List<ExerciseTypeSetSummary> exerciseTypeSetSummaries;

  List<List<ExerciseTypeSetSummary>> getRows(int itemsPerRow) {
    final rows = <List<ExerciseTypeSetSummary>>[];
    final possibleRows = (exerciseTypeSetSummaries.length / itemsPerRow).ceil();

    for (var i = 0; i < possibleRows; i++) {
      final startRangeIndex = i * itemsPerRow;
      final endRangeIndex = (i * itemsPerRow) + itemsPerRow;
      final isLastRow = endRangeIndex > exerciseTypeSetSummaries.length;
      rows.add(exerciseTypeSetSummaries.sublist(
          startRangeIndex, isLastRow ? exerciseTypeSetSummaries.length : endRangeIndex));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryShades.shade90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: StyledText.labelMedium(
                'Weekly Set Summary',
                bold: true,
              ),
            ),
            const SizedBox(height: 8),
            Column(
                children: getRows(4).map((row) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((e) {
                    return Expanded(
                        child: Center(
                            child:
                                StyledText.labelSmall('${e.exerciseType.toUpperCase()}: ${e.totalSets}', bold: true)));
                  }).toList());
            }).toList()),
          ],
        ),
      ),
    );
  }
}
