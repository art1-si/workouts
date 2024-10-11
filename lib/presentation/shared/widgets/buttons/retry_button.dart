import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/typography.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({
    super.key,
    required this.onPressed,
  });
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          const Icon(Icons.refresh),
          StyledText.button('Retry'),
        ],
      ),
    );
  }
}
