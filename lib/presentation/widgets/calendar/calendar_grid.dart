import 'package:flutter/material.dart';

typedef WeekdayHeaderBuilder = Widget Function(int);

enum SideLabelSize {
  big,
  small,
  none;

  double get sideLabelFlexColumnWidth {
    return switch (this) {
      SideLabelSize.big => 0.5,
      SideLabelSize.small => 0.3,
      SideLabelSize.none => 0.0000001,
    };
  }
}

/// Base widget for Calendar.
///
/// It's a very core of the widget, but it doesn't include any business logic or change of state.
class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    super.key,
    required this.weeks,
    required this.sideLabelSize,
    this.calendarContentPadding = EdgeInsets.zero,
  });

  final List<TableRow> weeks;

  final SideLabelSize sideLabelSize;

  final EdgeInsetsGeometry calendarContentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: calendarContentPadding,
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(sideLabelSize.sideLabelFlexColumnWidth),
        },
        children: [
          ...weeks,
        ],
      ),
    );
  }
}
