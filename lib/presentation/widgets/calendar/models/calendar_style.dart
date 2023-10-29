import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workouts/global/extensions/date_time.dart';
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
  // List<String> weekDaysAbbr(AppLocalizations localization) {
  //   return [
  //     localization.mondayAbbr,
  //     localization.tuesdayAbbr,
  //     localization.wednesdayAbbr,
  //     localization.thursdayAbbr,
  //     localization.fridayAbbr,
  //     localization.saturdayAbbr,
  //     localization.sundayAbbr,
  //   ];
  // }

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
      headerBuilder: (index) => StyledText.body(index.toString()),
      titleBuilder: (date) => Padding(
        padding: const EdgeInsets.only(
          left: 21,
          top: 27,
          bottom: 17,
        ),
        child: StyledText.body(date.isCurrentYear ? DateFormat.MMMM().format(date) : DateFormat.yMMMM().format(date)),
      ),
      activeDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        height: 40,
        child: Center(
          child: StyledText.body(
            date.day.toString(),
          ),
        ),
      ),
      todayDateCellBuilder: (date) => Center(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              60,
            ),
          ),
          child: Center(
            child: StyledText.body(
              date.day.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
