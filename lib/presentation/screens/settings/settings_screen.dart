import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StyledText.headline1('Settings Screen'),
      ),
    );
  }
}
