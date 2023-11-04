import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_grid.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_view.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/widgets/calendar/models/date_picker_style.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    required this.datePickerController,
  });
  final CalendarDatePickerController datePickerController;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: AppColors.primaryShades.shade90,
      child: InfiniteScrollDatePicker(
        selectionType: DatePickerSelectionType.singleDate,
        controller: widget.datePickerController,
        sideLabelSize: SideLabelSize.none,
        style: DatePickerStyle.logOverview(),
      ),
    );
  }
}
