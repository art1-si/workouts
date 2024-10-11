import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../lib.old/application/workout_logs/workout_logs_event_peak_for_date_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/typography.dart';
import '../infinite_scroll_calendar.dart';
import 'calendar_style.dart';
import '../../../../../dev_tools/logger/logger.dart';

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

  static Widget _eventPeekBuilder(DateTime date, WidgetRef ref) {
    final events = ref.watch(workoutLogsEventPeakForDateProvider(date));

    return events.when(
      data: (hasEvents) => hasEvents
          ? Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: AppColors.primaryShades.shade70,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          : Container(),
      loading: Container.new,
      error: (error, stackTrace) {
        Logger.warning(error.toString(), stackTrace: stackTrace);
        return Container();
      },
    );
  }

  factory DatePickerStyle.logOverview({required WidgetRef ref}) {
    final defaultCalendarStyle = CalendarStyle.initial();
    return DatePickerStyle(
      weekNumberBuilder: defaultCalendarStyle.weekNumberBuilder,
      headerBuilder: defaultCalendarStyle.headerBuilder,
      activeDateCellBuilder: (date) => Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 55,
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
                  _eventPeekBuilder(date, ref),
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
                      color: AppColors.accent,
                    ),
                  ),
                  _eventPeekBuilder(date, ref),
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
            height: 55,
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
                  _eventPeekBuilder(date, ref),
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
