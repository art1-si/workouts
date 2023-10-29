import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/global/models/date_system.dart';

/// Week number that also includes a year for that week.
class WeekNumber {
  WeekNumber(this.weekNumber, this.year, this.dateSystem);
  final int weekNumber;
  final int year;
  final DateSystem dateSystem;

  /// [WeekNumber] from current time.
  factory WeekNumber.now({required DateSystem dateSystem}) {
    return DateTime.now().weekNumber(dateSystem: dateSystem);
  }

  /// Expects the PMT format 2023-05
  factory WeekNumber.fromString(String yearWeek, {required DateSystem dateSystem}) {
    final components = yearWeek.split('-');
    if (components.length != 2) {
      throw FormatException('WeekNumber cannot be parsed from $yearWeek');
    }
    final year = int.parse(components.first);
    final week = int.parse(components.last);
    return WeekNumber(week, year, dateSystem);
  }

  /// Method calculates the difference in weeks between the current week and a specified date,
  ///  based on the provided [DateSystem].
  int weekDifferenceFromNow({required DateSystem dateSystem}) {
    final now = WeekNumber.now(dateSystem: dateSystem);
    return weekDifference(now, dateSystem: dateSystem);
  }

  /// Method calculates the difference in weeks between two [WeekNumber] objects, one representing the `this` week
  /// and the other specified as a parameter. The calculation is based on the provided [DateSystem].
  int weekDifference(WeekNumber other, {required DateSystem dateSystem}) {
    final firstDayOfTheWeekForOther = other.firstDayOfTheWeek;
    final firstDayOfTheWeekForThis = firstDayOfTheWeek;
    return firstDayOfTheWeekForThis.difference(firstDayOfTheWeekForOther).inDays ~/ 7;
  }

  /// Returns a weeknumber for the week relative to the current week given an offset.
  /// So plus (or minus, if negative) `offset` weeks
  static WeekNumber weekNumberRelativeToCurrentWeek({required int offset, required DateSystem dateSystem}) {
    return WeekNumber.now(dateSystem: dateSystem) + offset;
  }

  /// First shifts the week number by `difference`, then
  /// returns the start date of that week.
  static DateTime firstDateForWeekNumberDifference(int difference, {required DateSystem dateSystem}) {
    final weekNumberForDate = weekNumberRelativeToCurrentWeek(offset: difference, dateSystem: dateSystem);
    return weekNumberForDate.dateTimeForStartDay;
  }

  /// The [DateTime] object representing the first day of this week.
  DateTime get dateTimeForStartDay {
    switch (dateSystem) {
      case DateSystem.iso:
        {
          // January 4th is always in week 1
          final fourthJanuary = DateTime(year, 1, 4);

          // removing the weekday from January 4th returns the monday of week 1, which could be in the preceding year.
          final firstMondayOfWeek1 = DateTime(year, 1, 4 - (fourthJanuary.weekday - 1));

          // Not using DateTime.add() since that adds a duration which takes things such as daylight savings into account, which could introduce errors.
          return DateTime(
            firstMondayOfWeek1.year,
            firstMondayOfWeek1.month,
            firstMondayOfWeek1.day + 7 * (weekNumber - 1) + (dateSystem.startDayOfWeek - 1),
          );
        }
      case DateSystem.us:
        {
          final januaryFirst = DateTime(year, 1, 1);
          final sundayOfJanuaryFirst = januaryFirst.weekStartInSameWeek(dateSystem: dateSystem);
          return sundayOfJanuaryFirst.add(Duration(days: (weekNumber - 1) * 7));
        }
    }
  }

  /// Returns first date for this week number.
  DateTime get firstDayOfTheWeek => allDaysInWeek.first;

  /// Returns last date for this week number.
  DateTime get lastDayOfTheWeek => allDaysInWeek.last;

  /// Return all days in this week
  List<DateTime> get allDaysInWeek {
    final dateRange = <DateTime>[];

    for (var index = 0; index < DateTime.daysPerWeek; index++) {
      dateRange.add(dateTimeForStartDay.add(Duration(days: index)));
    }
    return dateRange;
  }

  /// Given a weekday (Monday: 1, Sunday: 7) returns the DateTime
  /// from `allDaysInWeek`.
  DateTime dateTimeForWeekday(int weekday) {
    return switch (dateSystem) {
      DateSystem.iso => allDaysInWeek[(weekday - 1) % 7],
      DateSystem.us => allDaysInWeek[weekday % 7],
    };
  }

  /// Combines the `year` and `weekNumber` into the `week` parameter for the PMT Api.
  String get pmtWeekNumberAPIParam => '$year-$weekNumber';

  /// Add a number of weeks
  WeekNumber operator +(int b) {
    final thisWeekStartDate = dateTimeForStartDay.copyWith(hour: 12);
    final resultWeekStartDate = thisWeekStartDate.add(Duration(days: b * 7));
    return resultWeekStartDate.weekNumber(dateSystem: dateSystem);
  }

  @override
  String toString() => 'CalendarWeekNumber(weekNumber: $weekNumber, year: $year)';

  @override
  bool operator ==(covariant WeekNumber other) {
    if (identical(this, other)) return true;

    return other.weekNumber == weekNumber && other.year == year;
  }

  @override
  int get hashCode => weekNumber.hashCode ^ year.hashCode;
}
