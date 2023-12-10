import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/global/extensions/date_time.dart';

final selectedDateProvider = NotifierProvider<SelectedDateController, DateTime>(
  SelectedDateController.new,
);

class SelectedDateController extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now().atNoon;

  void setDate(DateTime date) {
    state = date.atNoon;
  }
}
