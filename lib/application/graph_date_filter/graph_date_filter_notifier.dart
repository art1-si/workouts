import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/injection_providers.dart';

final graphDateFilterNotifierProvider = NotifierProvider<GraphDateFilterNotifier, DateTime?>(() {
  return GraphDateFilterNotifier();
});

class GraphDateFilterNotifier extends Notifier<DateTime?> {
  static const _graphDateFilterKey = 'graph_date_filter';

  @override
  DateTime? build() {
    final sharedPref = ref.read(sharedPrefProvider);
    final date = sharedPref.getString(_graphDateFilterKey);
    return date != null ? DateTime.tryParse(date) : null;
  }

  void set(DateTime? date) {
    final sharedPref = ref.read(sharedPrefProvider);
    if (date != null) {
      sharedPref.setString(_graphDateFilterKey, date.toIso8601String());
    } else {
      sharedPref.remove(_graphDateFilterKey);
    }

    state = date;
  }
}
