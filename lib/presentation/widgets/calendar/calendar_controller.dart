import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/global/models/date_system.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_page_view/infinite_page_controller.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';

/// Typedef for list of dates in the week.
typedef CalendarWeekDates = List<DateTime>;

/// Calendar dates that will be displayed.
typedef CalendarViewDates = Map<int, CalendarWeekDates>;

typedef DateValidator = bool Function(DateTime);

/// [CalendarController] for `CalendarViewDatePicker`.
class CalendarDatePickerController extends CalendarController {
  CalendarDatePickerController({
    this.startDateValidator,
    this.endDateValidator,
    super.initialPage,
    super.initialCalendarView,
    DateTime? defaultStartDate,
    DateTime? defaultEndDate,
  })  : _startDate = ValueNotifier(defaultStartDate ?? DateTime.now()),
        _endDate = ValueNotifier(defaultEndDate ?? DateTime.now().add(const Duration(days: 1)));
  final ValueNotifier<DateTime?> _startDate;
  final ValueNotifier<DateTime?> _endDate;

  /// [ValueNotifier] of start date.
  ///
  /// Allows you to listen changes to start date.
  ValueNotifier<DateTime?> get startDateNotifier => _startDate;

  /// [ValueNotifier] of end date.
  ///
  /// Allows you to listen changes to end date.
  ValueNotifier<DateTime?> get endDateNotifier => _startDate;

  /// Validator for dates that can be start date, and are selectable.
  ///
  /// If the `date` doesn't pass validation will be treated as inactive,
  /// and user won't be able to select it.
  final bool Function(DateTime)? startDateValidator;

  /// Validator for dates that can be end date, and are selectable.
  ///
  /// If the `date` doesn't pass validation will be treated as inactive,
  /// and user won't be able to select it.
  final bool Function(DateTime date, DateTime startDate)? endDateValidator;

  /// Start date for the date range.
  DateTime? get dateRangeStartDate => _startDate.value;

  /// End date for the date range.
  DateTime? get dateRangeEndDate => _endDate.value;

  /// It updates initial page view so when date picker is opened initial page is always
  /// the same as [_startDate]'s.
  void _updateInitialPageIndex() {
    if (dateRangeStartDate == null) {
      initialPage = 0;

      return;
    }
    switch (value) {
      case CalendarViewType.weekly:
        final weekNumberForSelectedStartingDate = dateRangeStartDate!.weekNumber(dateSystem: DateSystem.forUser);

        initialPage = weekNumberForSelectedStartingDate.weekDifferenceFromNow(dateSystem: DateSystem.forUser);
        break;
      case CalendarViewType.monthly:
        final now = DateTime.now();

        final startDateMonthAmount = dateRangeStartDate!.year * 12 + dateRangeStartDate!.month;
        final nowMonthAmount = now.year * 12 + now.month;

        initialPage = startDateMonthAmount - nowMonthAmount;
        break;
    }
  }

  /// Setter for Date range starting date.
  ///
  /// It will `notifyListeners` when setting value is different from current one.
  set dateRangeStartDate(DateTime? value) {
    if (value != _startDate.value) {
      _startDate.value = value;

      /// When starting date is being set as greater date than ending date. Set ending date to equal starting date.
      if (_endDate.value != null && _endDate.value!.isBefore(_startDate.value!)) {
        _endDate.value = _startDate.value;
      }
      _updateInitialPageIndex();
      notifyListeners();
    }
  }

  /// Setter for Date range ending date.
  ///
  /// It will `notifyListeners` when setting value is different from current one.
  set dateRangeEndDate(DateTime? value) {
    if (value != _endDate.value) {
      _endDate.value = value;
      notifyListeners();
    }
  }
}

/// Provides methods and properties to control and manage a [InfiniteScrollCalendar] widget.
///
/// Includes animating forward and backward, changing the calendar view type
/// from monthly view to weekly, and retrieving the current state of the view.
///
/// The `value` of [ValueListenable] is a [CalendarViewType] that is used to determine
/// which Calendar view should be used.
class CalendarController extends ChangeNotifier implements ValueListenable<CalendarViewType> {
  CalendarController({
    CalendarViewType? initialCalendarView,
    int initialPage = 0,
  })  : _state = initialCalendarView ?? CalendarViewType.monthly,
        _initialPage = initialPage;

  // ignore: prefer_final_fields
  int _initialPage;
  set initialPage(int value) {
    _initialPage = value;
    pageViewController.initialPage = _initialPage;
    if (pageViewController.positions.isNotEmpty) {
      pageViewController.jumpToPage(_initialPage);
    }
  }

  int get currentPageIndex => pageViewController.page!.round();

  int get initialPage => _initialPage;

  late final _monthlyViewPageController = InfinitePageController(initialPage: _initialPage);
  late final _weeklyViewPageController = InfinitePageController(initialPage: _initialPage);

  InfinitePageController get pageViewController {
    return switch (_state) {
      CalendarViewType.monthly => _monthlyViewPageController,
      CalendarViewType.weekly => _weeklyViewPageController,
    };
  }

  /// Animates calendar to one month forward.
  void animateForward({Duration duration = const Duration(milliseconds: 350), Curve curve = Curves.bounceInOut}) {
    final currentPage = pageViewController.page!;
    pageViewController.animateToPage(currentPage.round() + 1, duration: duration, curve: curve);
  }

  /// Animates calendar to one month backward.
  void animateBack({Duration duration = const Duration(milliseconds: 350), Curve curve = Curves.bounceInOut}) {
    final currentPage = pageViewController.page!;
    pageViewController.animateToPage(currentPage.round() - 1, duration: duration, curve: curve);
  }

  /// Checks if first day of the week is Monday or Sunday.
  bool get isFirstDayAMonday => DateSystem.forUser.startDayOfWeek == DateTime.monday;

  var _state = CalendarViewType.monthly;

  set calendarView(CalendarViewType newValue) {
    if (newValue != _state) {
      _state = newValue;
      notifyListeners();
    }
    return;
  }

  @override
  CalendarViewType get value => _state;
}
