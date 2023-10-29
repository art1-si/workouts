import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/home/widgets/logs_list_view.dart';
import 'package:workouts/presentation/widgets/calendar/calendar_grid.dart';
import 'package:workouts/presentation/widgets/calendar/infinite_scroll_calendar.dart';
import 'package:workouts/presentation/widgets/calendar/models/date_picker_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InfiniteScrollDatePicker(
            sideLabelSize: SideLabelSize.none,
            style: DatePickerStyle.initial(),
          ),
          LogsListView(),
        ],
      ),
    );
  }
}
