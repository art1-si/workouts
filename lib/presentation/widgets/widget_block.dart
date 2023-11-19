import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class WidgetBlock extends StatelessWidget {
  const WidgetBlock({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryShades.shade100,
        ),
        child: child,
      ),
    );
  }
}
