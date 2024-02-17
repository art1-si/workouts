import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.color,
  });

  final FutureOr<void> Function() onPressed;
  final Widget child;
  final bool disabled;
  final Color? color;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.onPressed();
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
      child: Opacity(
        opacity: widget.disabled ? 0.5 : 1,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.disabled ? Colors.white10 : widget.color ?? Colors.amber[900],
          ),
          child: Center(
            child: _isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryShades.shade100,
                    ),
                  )
                : widget.child,
          ),
        ),
      ),
    );
  }
}
