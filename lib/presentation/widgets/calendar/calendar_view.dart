import 'package:flutter/material.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/global/models/date_system.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_grid.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/widgets/calendar/models/calendar_style.dart';
import 'package:workouts/presentation/widgets/calendar/models/date_picker_style.dart';

enum DatePickerSelectionType {
  singleDate,
  weekSet,
  range,
}

/// Date picker calendar view.
///
///  It's a generic Calendar widget that is a subtype of [CalendarView].
/// It's a building block for [InfiniteScrollDatePicker] widget.
// ignore: must_be_immutable
class DatePickerCalendarView extends CalendarView {
  DatePickerCalendarView({
    super.key,
    required super.index,
    required CalendarDatePickerController controller,
    required this.datePickerStyle,
    required this.resettingDate,
    required this.resettingDateStateChanged,
    this.onDateRangeSelected,
    super.onDateTapped,
    this.onlyReselectEndRangeDate = false,
    required super.sideLabelSize,
    this.selectionType = DatePickerSelectionType.range,
  }) : super(controller: controller, style: datePickerStyle);

  /// Flag for case where you only want to select end date.
  ///
  /// This flag will be ignored if starting date was not yet set.
  final bool onlyReselectEndRangeDate;

  final void Function(DateTime startDate, DateTime? endDate)? onDateRangeSelected;

  final DatePickerSelectionType selectionType;

  final bool resettingDate;

  final void Function(bool) resettingDateStateChanged;

  late final _controller = controller as CalendarDatePickerController;

  final DatePickerStyle datePickerStyle;

  bool _insideValidRange(DateTime date) {
    if (resettingDate && !onlyReselectEndRangeDate) {
      return (_controller.startDateValidator?.call(date) ?? true);
    }
    return (_controller.endDateValidator?.call(date, _controller.dateRangeStartDate!) ?? true);
  }

  void _notifyOnRangeSelected() => onDateRangeSelected?.call(
        _controller.dateRangeStartDate!,
        _controller.dateRangeEndDate,
      );

  @override
  void onCurrentMonthDateTapped(DateTime date) {
    /// When date doesn't pass validation just return and don't select anything.
    if (!_insideValidRange(date)) {
      return;
    }

    if (selectionType == DatePickerSelectionType.singleDate) {
      _controller
        ..dateRangeStartDate = date
        ..dateRangeEndDate = date;
      _notifyOnRangeSelected();
      return;
    }

    if (selectionType == DatePickerSelectionType.weekSet) {
      final weekNumberForDate = date.weekNumber(dateSystem: DateSystem.forUser);
      final dateRangeForWeekNumber = weekNumberForDate.allDaysInWeek;
      _controller
        ..dateRangeStartDate = dateRangeForWeekNumber.first
        ..dateRangeEndDate = dateRangeForWeekNumber.last;
      _notifyOnRangeSelected();
      return;
    }

    /// When selecting only single date. Select starting date and notify using [_notifyOnRangeSelected].
    if (selectionType != DatePickerSelectionType.range) {
      _controller.dateRangeStartDate = date;
      _notifyOnRangeSelected();
      return;
    }

    /// When date is not reselected or user is re-selecting end date only.
    if ((!resettingDate || onlyReselectEndRangeDate) &&
        _controller.dateRangeStartDate != null &&
        (!date.isBefore(_controller.dateRangeStartDate!) || date.isEqual(_controller.dateRangeStartDate!))) {
      _controller.dateRangeEndDate = date;
      _notifyOnRangeSelected();
      return;

      /// If any of the above case don't match to this [date], then we set it as a starting date.
    } else {
      _controller
        ..dateRangeStartDate = date
        ..dateRangeEndDate = null;
      resettingDateStateChanged(false);
      return;
    }
  }

  @override
  Widget currentMonthBuilder(DateTime date) {
    /// When date doesn't pass validation just return and don't select anything.
    if (!_insideValidRange(date)) {
      return datePickerStyle.inactiveDateCellBuilder(date);
    }

    /// Case when `date` is today.
    if (date.isToday()) {
      return style.todayDateCellBuilder(date);
    }

    if (_insideValidRange(date) &&
        selectionType == DatePickerSelectionType.singleDate &&
        _controller.dateRangeStartDate != null &&
        date.isEqual(_controller.dateRangeStartDate!)) {
      return datePickerStyle.singleSelectableSelectedDateCellBuilder?.call(date) ??
          datePickerStyle.selectedStartDateCellBuilder(date);
    }

    if (_insideValidRange(date) &&
        selectionType != DatePickerSelectionType.singleDate &&
        _controller.dateRangeStartDate != null &&
        date.isEqual(_controller.dateRangeStartDate!)) {
      return datePickerStyle.singleSelectableSelectedDateCellBuilder?.call(date) ??
          datePickerStyle.selectedStartDateCellBuilder(date);
    }

    /// Case when `date` is starting date of range.
    if (selectionType != DatePickerSelectionType.singleDate &&
        _controller.dateRangeStartDate != null &&
        _controller.dateRangeStartDate!.isEqual(date)) {
      return datePickerStyle.selectedStartDateCellBuilder(date);
    }

    /// Case when `date` is ending date of range.
    if (selectionType != DatePickerSelectionType.singleDate &&
        _controller.dateRangeEndDate != null &&
        _controller.dateRangeEndDate!.isEqual(date)) {
      return datePickerStyle.selectedEndDateCellBuilder?.call(date) ??
          datePickerStyle.selectedStartDateCellBuilder(date);
    }

    /// Case when `date` is inbetween starting and ending dates.
    if (selectionType != DatePickerSelectionType.singleDate &&
        _controller.dateRangeStartDate != null &&
        _controller.dateRangeEndDate != null &&
        date.isInBetween(_controller.dateRangeStartDate!, _controller.dateRangeEndDate!)) {
      return datePickerStyle.selectedBetweenDateCellBuilder?.call(date) ??
          datePickerStyle.selectedStartDateCellBuilder(date);
    }

    /// When `date` is selectable range.
    if (_insideValidRange(date)) {
      return style.activeDateCellBuilder(date);
    }
    return datePickerStyle.inactiveDateCellBuilder(date);
  }
}

/// Calendar view widget.
///
/// It's a generic Calendar widget that shows a month based on the `monthDifferenceIndex`.
/// It's a building block for [InfiniteScrollCalendar] widget.
///
/// `monthDifferenceIndex` is used to calculate month to display, where index `0` is current month,
/// index `1` is one month forward, and `-1` is one month back.
/// This allows to create infinite list of month with widgets [ListView.builder], or [PageView.builder].
class CalendarView extends StatefulWidget {
  CalendarView({
    super.key,
    required this.style,
    required this.controller,
    required int index,
    this.onDateTapped,
    required this.sideLabelSize,
  }) {
    final now = DateTime.now();
    if (controller.value == CalendarViewType.monthly) {
      dateToDisplay = DateTime(now.year, now.month + index, 1).atNoon;
    } else {
      dateToDisplay = DateTime(now.year, now.month, now.day + (7 * index)).atNoon;
    }
  }

  /// Month which this [CalendarView] will display.
  late final DateTime dateToDisplay;

  final CalendarController controller;

  final CalendarStyle style;

  final DateTimeCallback? onDateTapped;

  final SideLabelSize sideLabelSize;

  @override
  State<CalendarView> createState() => _CalendarViewState();

  /// Function that is called when user taps on the date cell.
  ///
  // This function has to be here and not in the `State` class. This allows to abstract the `CalendarView` and execute different onTapped behaviour, like for DatePicker.
  void onCurrentMonthDateTapped(DateTime date) => onDateTapped?.call(date);

  // This function has to be here and not in the `State` class. This allows to abstract the `CalendarView` and render cells differently, for example like for the DatePicker where we need to render onSelected cell.
  Widget currentMonthBuilder(DateTime date) {
    if (date.isToday()) {
      return style.todayDateCellBuilder(date);
    }

    return style.activeDateCellBuilder(date);
  }
}

class _CalendarViewState extends State<CalendarView> {
  /// Calculates the number of rows required to display a calendar view for a given month.
  ///
  /// This method takes into account the total number of days to display in the calendar
  /// and the offset of the first day of the month, allowing you to determine how many
  /// rows are needed to display all the days of the month in a calendar grid.
  int numberOfRowsForCalendarView(int totalAmountOfDaysToDisplay) {
    final firstDayOfTheMonthOffset = widget.dateToDisplay.firstDayOfTheMonthOffset;

    return ((totalAmountOfDaysToDisplay + firstDayOfTheMonthOffset) / 7).ceil();
  }

  /// Generates data for the calendar.
  ///
  /// It will map them with a week number as a key.
  CalendarViewDates mappedDates(BuildContext context) {
    final result = <int, List<DateTime>>{};

    final currentDateRange = widget.controller.value == CalendarViewType.monthly
        ? widget.dateToDisplay.allDaysInMonth
        : widget.dateToDisplay.allDaysInWeek(dateSystem: DateSystem.forUser);

    final firstDayOffset = DateSystem.forUser.startDayOfWeek == DateTime.monday ? 0 : -1;

    if (widget.controller.value == CalendarViewType.weekly) {
      var rowAmount = 1;

      final firstDayOfTheWeek = widget.dateToDisplay.add(
        Duration(
          days: (-widget.dateToDisplay.weekday + 1) + firstDayOffset,
        ),
      );
      for (var rowIndex = 0; rowIndex < rowAmount; rowIndex++) {
        final datesPerRow = <DateTime>[];

        for (var daysPerWeekIndex = 0; daysPerWeekIndex < DateTime.daysPerWeek; daysPerWeekIndex++) {
          final cellIndex = daysPerWeekIndex;
          datesPerRow.add(
            firstDayOfTheWeek.add(
              Duration(
                days: cellIndex,
              ),
            ),
          );
        }
        final weekNumberForRow = datesPerRow.last.weekNumber(dateSystem: DateSystem.forUser);

        result[weekNumberForRow.weekNumber] = datesPerRow;
      }
      return result;
    }

    var rowAmount = numberOfRowsForCalendarView(currentDateRange.length);

    for (var rowIndex = 0; rowIndex < rowAmount; rowIndex++) {
      final datesPerRow = <DateTime>[];

      for (var daysPerWeekIndex = 0; daysPerWeekIndex < DateTime.daysPerWeek; daysPerWeekIndex++) {
        final cellIndex = (rowIndex * 7) + daysPerWeekIndex;
        datesPerRow.add(
          widget.dateToDisplay.add(
            Duration(
              // We need to add 1 to weekday. This allows to correct calculation of the date position.
              days: cellIndex + (-widget.dateToDisplay.weekday + 1) + firstDayOffset,
            ),
          ),
        );
      }
      final weekNumberForRow = datesPerRow.last.weekNumber(dateSystem: DateSystem.forUser);

      result[weekNumberForRow.weekNumber] = datesPerRow;
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(controllerListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerListener);
    super.dispose();
  }

  /// Calendar controller listener.
  ///
  /// It listens for a callback from [CalendarController] and currently only `setState`.
  void controllerListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final calendarDates = mappedDates(context);
    final rows = calendarDates.keys.map(
      (row) {
        final mappedRow = calendarDates[row]!.map(
          (e) {
            if (widget.dateToDisplay.isSameMonth(e) || widget.controller.value == CalendarViewType.weekly) {
              return GestureDetector(
                onTap: () => widget.onCurrentMonthDateTapped(e),
                child: widget.currentMonthBuilder(e),
              );
            } else if (widget.style.outsideCurrentMonthCellBuilder != null) {
              return widget.style.outsideCurrentMonthCellBuilder!(e);
            } else {
              return const SizedBox();
            }
          },
        ).toList();
        if (widget.style.weekNumberBuilder != null) {
          mappedRow.insert(0, widget.style.weekNumberBuilder!(row));
        }

        return TableRow(children: mappedRow);
      },
    ).toList();
    return CalendarGrid(
      sideLabelSize: widget.sideLabelSize,
      weeks: rows,
      calendarContentPadding: widget.style.calendarContentPadding,
    );
  }
}
