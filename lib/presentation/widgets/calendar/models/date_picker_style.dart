import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/widgets/calendar/models/calendar_style.dart';

class DatePickerStyle extends CalendarStyle {
  DatePickerStyle({
    required super.activeDateCellBuilder,
    required super.todayDateCellBuilder,
    required super.calendarContentPadding,
    required this.selectedStartDateCellBuilder,
    this.selectedBetweenDateCellBuilder,
    this.selectedEndDateCellBuilder,
    required this.singleSelectableSelectedDateCellBuilder,
    required this.inactiveDateCellBuilder,
    required super.titleBuilder,
    required super.headerBuilder,
    required super.weekNumberBuilder,
  });

  /// Cell builder for Date range, starting date.
  final DateTimeIndexedBuilder selectedStartDateCellBuilder;

  /// Cell builder for Date range, ending date.
  final DateTimeIndexedBuilder? selectedEndDateCellBuilder;

  /// Cell builder for Date range, for dates inbetween start and end date.
  final DateTimeIndexedBuilder? selectedBetweenDateCellBuilder;

  /// Builder for dates that did not passed `CalendarDatePickerController.startDateValidator`
  /// or `CalendarDatePickerController.endDateValidator`.
  ///
  /// If `CalendarDatePickerController.startDateValidator` is `null` then all the dates will be treated as active.
  final DateTimeIndexedBuilder inactiveDateCellBuilder;

  final DateTimeIndexedBuilder singleSelectableSelectedDateCellBuilder;

  factory DatePickerStyle.logOverview() {
    final defaultCalendarStyle = CalendarStyle.initial();
    return DatePickerStyle(
      weekNumberBuilder: defaultCalendarStyle.weekNumberBuilder,
      headerBuilder: defaultCalendarStyle.headerBuilder,
      activeDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 50,
            width: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Center(
                    child: StyledText.bodyLarge(
                      date.day.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      todayDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 50,
            width: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Center(
                    child: StyledText.bodyLarge(
                      date.day.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      calendarContentPadding: defaultCalendarStyle.calendarContentPadding,
      selectedStartDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      singleSelectableSelectedDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 50,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryShades.shade80,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Center(
                    child: StyledText.bodyLarge(
                      date.day.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      inactiveDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      titleBuilder: defaultCalendarStyle.titleBuilder,
    );
  }
}
