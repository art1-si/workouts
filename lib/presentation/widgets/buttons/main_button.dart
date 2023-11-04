import 'dart:async';

import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final FutureOr<void> Function() onPressed;
  final Widget child;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });
        await widget.onPressed();
        setState(() {
          _isLoading = false;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber[800],
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : widget.child,
        ),
      ),
    );
  }
}
