import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_grid.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';

class CalendarStyle {
  const CalendarStyle({
    required this.titleBuilder,
    required this.activeDateCellBuilder,
    required this.todayDateCellBuilder,
    required this.headerBuilder,
    this.calendarContentPadding = EdgeInsets.zero,
    this.outsideCurrentMonthCellBuilder,
    this.weekNumberBuilder,
  });
  static List<String> weekDaysAbbr() {
    return [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];
  }

  final WeekdayHeaderBuilder headerBuilder;

  /// Builder for cells for selected month.
  final DateTimeIndexedBuilder activeDateCellBuilder;

  /// Builder for cells for Today date.
  final DateTimeIndexedBuilder todayDateCellBuilder;

  /// Builder for cells that are outside currently selected month.
  ///
  /// When left `null`, dates will not be displayed.
  final DateTimeIndexedBuilder? outsideCurrentMonthCellBuilder;

  final IntIndexedBuilder? weekNumberBuilder;

  final EdgeInsetsGeometry calendarContentPadding;

  final Widget Function(DateTime) titleBuilder;

  factory CalendarStyle.initial() {
    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    return CalendarStyle(
      calendarContentPadding: const EdgeInsets.only(bottom: 4.0),
      weekNumberBuilder: null,
      headerBuilder: (index) => Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Center(child: StyledText.labelSmall(weekDaysAbbr()[index])),
      ),
      titleBuilder: (date) => Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: StyledText.labelMedium(DateFormat.yMMMM().format(date)),
      ),
      activeDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        height: 50,
        child: Center(
          child: StyledText.bodyLarge(
            date.day.toString(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      todayDateCellBuilder: (date) => Center(
        child: Container(
          height: 50,
          width: 40,
          child: Center(
            child: StyledText.bodyLarge(
              date.day.toString(),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryShades.shade90,
            ),
          ),
        ),
      ),
    );
  }
}
