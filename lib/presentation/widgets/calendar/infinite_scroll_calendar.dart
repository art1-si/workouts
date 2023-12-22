import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_controller.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_grid.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_view.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_page_view/infinite_page_view.dart';
import 'package:workouts/presentation/widgets/calendar/models/calendar_style.dart';
import 'package:workouts/presentation/widgets/calendar/models/date_picker_style.dart';

/// Indexed builder with [DateTime] as its index.
typedef DateTimeIndexedBuilder = Widget Function(DateTime);

/// Callback with [DateTime] as its property.
typedef DateTimeCallback = void Function(DateTime);

/// Indexed builder with [int] as its index.
typedef IntIndexedBuilder = Widget Function(int);

/// Calendar view type.
///
/// Weekly or monthly.
enum CalendarViewType {
  monthly,
  weekly,
}

/// Date picker in the form of calendar.
///
/// Based on the [InfiniteScrollCalendar].
///
// CalendarDatePicker and DatePicker are taken by flutter material widgets, that is why is called CalendarViewDatePicker
class InfiniteScrollDatePicker extends InfiniteScrollCalendar {
  InfiniteScrollDatePicker({
    super.key,
    this.onlyReselectEndRangeDate = false,
    this.onDateRangeSelected,
    this.selectionType = DatePickerSelectionType.range,
    super.calendarContentPadding = EdgeInsets.zero,
    super.disablePageScroll,
    required super.sideLabelSize,
    this.showTitle = true,
    super.descendingIndexLimit,
    required this.style,
    CalendarDatePickerController? controller,
  }) : super(controller: controller ?? CalendarDatePickerController(), calendarStyle: style);

  /// Flag for only re-selecting end date from date range.
  ///
  /// This will be ignored if starting date was not selected yet.
  final bool onlyReselectEndRangeDate;

  final bool showTitle;

  /// Callback, for when date range was selected.
  ///
  /// When [selectionType] the `startDate` and `endDate` will be the same date.
  final void Function(DateTime startDate, DateTime? endDate)? onDateRangeSelected;

  final DatePickerSelectionType selectionType;

  final DatePickerStyle style;

  @override
  State<InfiniteScrollDatePicker> createState() => _InfiniteScrollDatePickerCalendarState();
}

class _InfiniteScrollDatePickerCalendarState extends State<InfiniteScrollDatePicker> {
  bool _resettingDate = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitle) widget.monthHeaderBuilder,
        widget.weekdayAbbrBuilder,
        SizedBox(
          height: widget.calendarController.value == CalendarViewType.monthly ? null : 60,
          child: InfinitePageView(
            descendingIndexLimit: widget.descendingIndexLimit,
            automaticResizing: widget.calendarController.value == CalendarViewType.monthly,
            controllerAutoDispose: false,
            controller: widget.calendarController.pageViewController,
            scrollPhysics: widget.disablePageScroll ? const NeverScrollableScrollPhysics() : null,
            itemBuilder: (context, index) {
              return DatePickerCalendarView(
                datePickerStyle: widget.style,
                sideLabelSize: widget.sideLabelSize,
                selectionType: widget.selectionType,
                index: index,
                onDateRangeSelected: widget.onDateRangeSelected,
                controller: widget.calendarController as CalendarDatePickerController,
                onlyReselectEndRangeDate: widget.onlyReselectEndRangeDate,
                resettingDate: _resettingDate,
                resettingDateStateChanged: (value) => setState(() {
                  _resettingDate = value;
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Infinite scroll Calendar.
///
/// Scrolls in both direction with infinite index.
class InfiniteScrollCalendar extends StatefulWidget {
  InfiniteScrollCalendar({
    super.key,
    this.onDateTapped,
    this.calendarContentPadding = EdgeInsets.zero,
    this.footer,
    this.automaticResizing = true,
    required this.sideLabelSize,
    this.disablePageScroll = false,
    this.calendarHeight,
    this.descendingIndexLimit,
    required this.calendarStyle,
    CalendarController? controller,
  }) {
    if (controller == null) {
      calendarController = CalendarController();
    } else {
      calendarController = controller;
    }
  }

  late final CalendarController calendarController;

  final EdgeInsets calendarContentPadding;

  /// Callback for when date cell was tapped.
  final DateTimeCallback? onDateTapped;

  final Widget Function(int index)? footer;

  final SideLabelSize sideLabelSize;

  final bool automaticResizing;

  /// Toggle to disable horizontal page scrolling.
  /// Note you still will be able to scroll using CalendarController.
  final bool disablePageScroll;

  /// Height of the calendar.
  ///
  /// If left null it will have automatic resizing, but if footer is provided then it will default to fixed value.
  final double? calendarHeight;

  final int? descendingIndexLimit;

  final CalendarStyle calendarStyle;

  Widget get monthHeaderBuilder {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12.0),
      child: _SwipeActions(
        calendarController: calendarController,
        label: _CalendarViewTitle(
          calendarController: calendarController,
          builder: calendarStyle.titleBuilder,
        ),
      ),
    );
  }

  Widget get weekdayAbbrBuilder {
    return Padding(
      padding: EdgeInsets.only(
        right: calendarContentPadding.right,
        left: calendarContentPadding.left,
      ),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(sideLabelSize.sideLabelFlexColumnWidth),
        },
        children: [
          TableRow(
            children: List.generate(7, calendarStyle.headerBuilder)
              ..insert(
                0,
                const SizedBox(),
              ),
          ),
        ],
      ),
    );
  }

  @override
  State<InfiniteScrollCalendar> createState() => _InfiniteScrollCalendarState();
}

class _InfiniteScrollCalendarState extends State<InfiniteScrollCalendar> {
  var currentPage = 0;

  InfinitePageView get infinitePageView {
    return InfinitePageView(
        descendingIndexLimit: widget.descendingIndexLimit,
        automaticResizing: widget.automaticResizing,
        controllerAutoDispose: false,
        controller: widget.calendarController.pageViewController,
        scrollPhysics: widget.disablePageScroll ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (context, index) {
          return CalendarView(
            index: index,
            style: widget.calendarStyle,
            controller: widget.calendarController,
            onDateTapped: widget.onDateTapped,
            sideLabelSize: widget.sideLabelSize,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.footer != null) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              widget.monthHeaderBuilder,
              widget.weekdayAbbrBuilder,
              SizedBox(
                height: widget.calendarHeight ?? 50,
                child: ValueListenableBuilder(
                  valueListenable: widget.calendarController,
                  builder: (context, calendarView, child) => infinitePageView,
                ),
              ),
            ],
          ),
          _Footer(
            calendarController: widget.calendarController,
            child: widget.footer!,
          ),
        ],
      );
    }
    return ValueListenableBuilder(
      valueListenable: widget.calendarController,
      builder: (context, calendarView, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.monthHeaderBuilder,
            widget.weekdayAbbrBuilder,
            Expanded(child: infinitePageView),
          ],
        );
      },
    );
  }
}

class _Footer extends StatefulWidget {
  const _Footer({
    required this.calendarController,
    required this.child,
  });
  final CalendarController calendarController;
  final Widget Function(int) child;

  @override
  State<_Footer> createState() => __FooterState();
}

class __FooterState extends State<_Footer> {
  late var currentPage = widget.calendarController.pageViewController.initialPage;

  @override
  void initState() {
    super.initState();
    widget.calendarController.pageViewController.addListener(pageControllerListener);
  }

  @override
  void dispose() {
    widget.calendarController.pageViewController.removeListener(pageControllerListener);
    super.dispose();
  }

  void pageControllerListener() {
    if (currentPage != widget.calendarController.pageViewController.pageRounded) {
      setState(() {
        currentPage = widget.calendarController.pageViewController.pageRounded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(currentPage);
  }
}

class _CalendarViewTitle extends StatefulWidget {
  const _CalendarViewTitle({
    required this.calendarController,
    required this.builder,
  });

  final CalendarController calendarController;

  final Widget Function(DateTime) builder;
  @override
  State<_CalendarViewTitle> createState() => _CalendarViewTitleState();
}

class _CalendarViewTitleState extends State<_CalendarViewTitle> {
  late var currentPage = widget.calendarController.pageViewController.initialPage;

  void pageViewListener() {
    if (currentPage != widget.calendarController.pageViewController.pageRounded) {
      setState(() {
        currentPage = widget.calendarController.pageViewController.pageRounded;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.calendarController.pageViewController.addListener(pageViewListener);
  }

  @override
  void dispose() {
    widget.calendarController.pageViewController.removeListener(pageViewListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final dateToDisplay = widget.calendarController.value == CalendarViewType.monthly
        ? DateTime(now.year, now.month + currentPage, 1)
        : DateTime(now.year, now.month, now.day + (7 * currentPage));
    return widget.builder(dateToDisplay);
  }
}

class _SwipeActions extends StatelessWidget {
  const _SwipeActions({
    required this.calendarController,
    required this.label,
  });

  final CalendarController calendarController;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: calendarController.animateBack,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppColors.primaryShades.shade80,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 32,
                  color: AppColors.primaryShades.shade70,
                ),
              ),
            ),
          ),
          label,
          GestureDetector(
            onTap: calendarController.animateForward,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppColors.primaryShades.shade80,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 32,
                color: AppColors.primaryShades.shade70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
