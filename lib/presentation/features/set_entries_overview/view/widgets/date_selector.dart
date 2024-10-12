import 'package:flutter/material.dart';
import 'package:workouts/presentation/features/calendar/view/calendar_controller.dart';
import 'package:workouts/presentation/features/calendar/view/calendar_grid.dart';
import 'package:workouts/presentation/features/calendar/view/calendar_view.dart';
import 'package:workouts/presentation/features/calendar/view/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/features/calendar/view/models/date_picker_style.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    required this.datePickerController,
  });
  final CalendarDatePickerController datePickerController;

  @override
  State<StatefulWidget> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: AppColors.primaryShades.shade90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InfiniteScrollDatePicker(
          selectionType: DatePickerSelectionType.singleDate,
          controller: widget.datePickerController,
          sideLabelSize: SideLabelSize.none,
          style: DatePickerStyle.logOverview(ref: ref),
          onDateRangeSelected: (startDate, endDate) => ref.read(selectedDateProvider.notifier).setDate(startDate),
        ),
      ),
    );
  }
}
