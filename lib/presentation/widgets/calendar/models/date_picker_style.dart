import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/widgets/calendar/models/calendar_style.dart';

class DatePickerStyle extends CalendarStyle {
  DatePickerStyle(
      {required super.activeDateCellBuilder,
      required super.todayDateCellBuilder,
      required super.calendarContentPadding,
      required this.selectedStartDateCellBuilder,
      this.selectedBetweenDateCellBuilder,
      this.selectedEndDateCellBuilder,
      required this.singleSelectableSelectedDateCellBuilder,
      required this.inactiveDateCellBuilder,
      required super.titleBuilder,
      required super.headerBuilder});

  /// Cell builder for Date range, starting date.
  final DateTimeIndexedBuilder selectedStartDateCellBuilder;

  /// Cell builder for Date range, ending date.
  final DateTimeIndexedBuilder? selectedEndDateCellBuilder;

  /// Cell builder for Date range, for dates inbetween start and end date.
  final DateTimeIndexedBuilder? selectedBetweenDateCellBuilder;

  /// Builder for dates that did not passed [CalendarDatePickerController.startDateValidator]
  /// or [CalendarDatePickerController.endDateValidator] .
  ///
  /// If [CalendarDatePickerController.startDateValidator] is `null` then all the dates will be treated as active.
  final DateTimeIndexedBuilder inactiveDateCellBuilder;

  final DateTimeIndexedBuilder singleSelectableSelectedDateCellBuilder;

  factory DatePickerStyle.initial() {
    final defaultCalendarStyle = CalendarStyle.initial();
    return DatePickerStyle(
      headerBuilder: defaultCalendarStyle.headerBuilder,
      activeDateCellBuilder: defaultCalendarStyle.activeDateCellBuilder,
      todayDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      calendarContentPadding: defaultCalendarStyle.calendarContentPadding,
      selectedStartDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      singleSelectableSelectedDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      inactiveDateCellBuilder: defaultCalendarStyle.todayDateCellBuilder,
      titleBuilder: defaultCalendarStyle.titleBuilder,
    );
  }
}
