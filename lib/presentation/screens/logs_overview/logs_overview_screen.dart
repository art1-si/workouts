import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/date_selector.dart';

class LogsOverviewScreen extends StatelessWidget {
  const LogsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          DateSelector(),
          // LogsListView(),
        ],
      ),
    );
  }
}
