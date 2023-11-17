import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/date_selector.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/logs_list_view.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';

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
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StyledText.headlineMedium('Workouts'),
            ),
          ),
          const SizedBox(height: 24),
          DateSelector(datePickerController: _datePickerController),
          const Expanded(child: LogsListView()),
        ],
      ),
    );
  }
}
