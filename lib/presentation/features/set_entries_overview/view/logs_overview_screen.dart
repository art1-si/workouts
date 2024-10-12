import 'package:flutter/material.dart';
import 'package:workouts/presentation/features/calendar/view/calendar_controller.dart';
import 'package:workouts/presentation/features/calendar/view/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'widgets/date_selector.dart';
import 'widgets/logs_list_view.dart';

class LogsOverviewScreen extends StatefulWidget {
  const LogsOverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LogsOverviewScreenState();
}

class _LogsOverviewScreenState extends State<LogsOverviewScreen> {
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
