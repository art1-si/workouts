import 'package:flutter/material.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  final String labelText;
  final TextEditingController controller;

  @override
  State<MainTextField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
