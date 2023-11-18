import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workouts/global/models/date_system.dart';
import 'package:workouts/global/models/week_number.dart';

extension PMTDateTimeFormatting on DateTime {
  /// Getter for `this` date that return midnight time.
  DateTime get atMidnight {
    return copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  String toPMTTimeViewFormat() {
    return DateFormat('Hm').format(this);
  }

  /// Date formatter in format `dd MMM yyyy`.
  String toPMTViewFormat() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  /// Date formatter in format `dd MMM`.
  String toPMTViewFormatShort() {
    return DateFormat('dd MMM').format(this);
  }

  String toPMTHeaderFormat() {
    return DateFormat(DateFormat.MONTH_WEEKDAY_DAY, Intl.getCurrentLocale()).format(this);
  }

  /// It will format `this` date in format of `yyyy-MM-dd`.
  String toPmtAPIParameterFormat() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formattedCurrentYearLastDate() {
    return DateFormat('dd MMM yyyy').format(copyWith(month: 12, day: 31));
  }

  String formattedNextYearLastDate() {
    return DateFormat('dd MMM yyyy').format(copyWith(year: year + 1, month: 12, day: 31));
  }

  static String timeRange(DateTime startTime, DateTime endTime) {
    return '${startTime.toPMTTimeViewFormat()} - ${endTime.toPMTTimeViewFormat()}';
  }
}

extension CalendarExtensions on DateTime {
  bool isToday() {
    return DateUtils.isSameDay(this, DateTime.now());
  }

  /// It will append `value` to month and it will reset day value to `1`.
  DateTime addMonthWithDayReset(int value) {
    return DateTime(year, month + value, 1);
  }

  /// Returns list of days for `this` month.
  List<DateTime> get allDaysInMonth {
    final dateRange = <DateTime>[];
    final daysInTheMonth = DateUtils.getDaysInMonth(year, month);

    for (var index = 0; index < daysInTheMonth; index++) {
      dateRange.add(copyWith(day: index + 1));
    }
    return dateRange;
  }

  DateTime get atNoon {
    return copyWith(hour: 12, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  /// Returns list of days for `this` week.
  List<DateTime> allDaysInWeek({required DateSystem dateSystem}) {
    return weekNumber(dateSystem: dateSystem).allDaysInWeek;
  }

  /// Whether or not `this` date and `other` are equal.
  ///
  /// This only checks for `day`, `month`, and a `year`.
  bool isEqual(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  /// Whether or not `this` date and `other` are equal.
  ///
  /// This checks date time milliseconds.
  bool isEqualToMilliseconds(DateTime other) {
    return other.millisecondsSinceEpoch == millisecondsSinceEpoch;
  }

  bool get isCurrentYear {
    return year == DateTime.now().year;
  }

  bool isInWeekNumber(WeekNumber weekNumber) {
    return isAfterOrEqual(weekNumber.firstDayOfTheWeek) && isBeforeOrEqual(weekNumber.lastDayOfTheWeek);
  }

  /// Whether or not `this` date is within the same month as `other`.
  bool isSameMonth(DateTime otherDate) {
    return DateUtils.isSameMonth(this, otherDate);
  }

  /// Whether or not `this` date is between `startDate` and `endDate`.
  bool isInBetween(DateTime startDate, DateTime endDate) {
    return isAfterOrEqual(startDate) && isBeforeOrEqual(endDate);
  }

  bool isBeforeOrEqual(DateTime date) {
    return isBefore(date) || isEqualToMilliseconds(date);
  }

  bool isAfterOrEqual(DateTime date) {
    return isAfter(date) || isEqualToMilliseconds(date);
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  /// The ordinal date, the number of days since December 31st the previous
  /// year.
  ///
  /// January 1st has the ordinal date 1
  ///
  /// December 31st has the ordinal date 365, or 366 in leap years
  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// Returns [WeekNumber] for `this` date.
  WeekNumber weekNumber({required DateSystem dateSystem}) {
    switch (dateSystem) {
      case DateSystem.iso:
        {
          // Add 3 to always compare with January 4th, which is always in week 1
          // Add 7 to index weeks starting with 1 instead of 0
          final woy = ((ordinalDate - weekday + 10) ~/ 7);

          // If the week number equals zero, it means that the given date belongs to
          // the preceding (week-based) year.
          if (woy == 0) {
            // The 28th of December is always in the last week of the year
            return DateTime(year - 1, 12, 28).weekNumber(dateSystem: dateSystem);
          }

          // If the week number equals 53, one must check that the date is not
          // actually in week 1 of the following year
          if (woy == 53 &&
              DateTime(year, 1, 1).weekday != DateTime.thursday &&
              DateTime(year, 12, 31).weekday != DateTime.thursday) {
            return WeekNumber(1, year, dateSystem);
          }

          return WeekNumber(
            woy,
            year,
            dateSystem,
          );
        }
      case DateSystem.us:
        {
          final sundayThisWeek = weekStartInSameWeek(dateSystem: dateSystem);
          final saturdayNextWeek = sundayThisWeek.add(const Duration(days: 6));
          final containsJanuaryFirst =
              saturdayNextWeek.year > sundayThisWeek.year || (sundayThisWeek.month == 1 && sundayThisWeek.day == 1);
          if (containsJanuaryFirst) {
            return WeekNumber(1, saturdayNextWeek.year, dateSystem);
          }

          return WeekNumber(
            ((ordinalDate - 1) / 7).floor() + 1,
            year,
            dateSystem,
          );
        }
    }
  }

  /// Calculates and returns the offset of the first day of the month in the context of a date system.
  ///
  /// It's used in places like calendar widget for calculating first day of the month position.
  int get firstDayOfTheMonthOffset {
    return switch (DateSystem.forUser) {
      DateSystem.iso => copyWith(day: 1).weekday - 1,
      DateSystem.us => copyWith(day: 1).weekday,
    };
  }

  /// Returns the [DateTime] for the first day in the week of `this` date
  DateTime weekStartInSameWeek({required DateSystem dateSystem}) {
    return switch (dateSystem) {
      DateSystem.iso => subtract(Duration(days: weekday - 1)),
      DateSystem.us => subtract(Duration(days: weekday % 7)),
    };
  }
}
