import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../lib.old/application/selected_date/selected_date_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../../lib.old/presentation/widgets/calendar/calendar_controller.dart';
import '../../../../../../lib.old/presentation/widgets/calendar/calendar_grid.dart';
import '../../../../../../lib.old/presentation/widgets/calendar/calendar_view.dart';
import '../../../../../../lib.old/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import '../../../../../../lib.old/presentation/widgets/calendar/models/date_picker_style.dart';

class DateSelector extends ConsumerStatefulWidget {
  const DateSelector({
    super.key,
    required this.datePickerController,
  });
  final CalendarDatePickerController datePickerController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateSelectorState();
}

class _DateSelectorState extends ConsumerState<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: AppColors.primaryShades.shade90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InfiniteScrollDatePicker(
          selectionType: DatePickerSelectionType.singleDate,
          controller: widget.datePickerController,
          sideLabelSize: SideLabelSize.none,
          style: DatePickerStyle.logOverview(ref: ref),
          onDateRangeSelected: (startDate, endDate) => ref.read(selectedDateProvider.notifier).setDate(startDate),
        ),
      ),
    );
  }
}
