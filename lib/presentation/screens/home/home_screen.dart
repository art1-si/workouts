import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/home/widgets/logs_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LogsListView(),
        ],
      ),
    );
  }
}
