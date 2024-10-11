import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../lib.old/presentation/features/weekly_set_count_summary/weekly_set_count_summery.dart';
import 'widgets/date_selector.dart';
import 'widgets/logs_list_view.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/typography.dart';
import '../../../../../lib.old/presentation/widgets/calendar/calendar_controller.dart';
import '../../../../../lib.old/presentation/widgets/calendar/infinite_scroll_calendar.dart';

class LogsOverviewScreen extends ConsumerStatefulWidget {
  const LogsOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsOverviewScreenState();
}

class _LogsOverviewScreenState extends ConsumerState<LogsOverviewScreen> {
  final CalendarDatePickerController _datePickerController =
      CalendarDatePickerController(initialCalendarView: CalendarViewType.weekly);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 48,
            color: AppColors.primaryShades.shade90,
          ),
          Container(
            height: 24,
            color: AppColors.primaryShades.shade90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.center,
                child: StyledText.headlineSmall('Workouts'.toUpperCase()),
              ),
            ),
          ),
          DateSelector(datePickerController: _datePickerController),
          // WeeklySetCountSummery(calendarController: _datePickerController),
          const Expanded(child: LogsListView()),
        ],
      ),
    );
  }
}
