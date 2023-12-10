import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/typography.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StyledText.headline1('This is the Plan Screen'),
      ),
    );
  }
}
