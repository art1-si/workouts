import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/base_tf_num_picker.dart';

class TextFieldNumberPicker extends StatefulWidget {
  const TextFieldNumberPicker({
    Key? key,
    required this.title,
    required this.initValue,
    required this.onChange,
    required this.changesByValue,
  }) : super(key: key);

  final String title;
  final int initValue;
  final ValueChanged<int> onChange;
  final int changesByValue;

  @override
  State<TextFieldNumberPicker> createState() => _TextFieldNumberPickerState();
}

class _TextFieldNumberPickerState extends State<TextFieldNumberPicker> {
  late final _controller = TextEditingController(text: widget.initValue.toString());
  late int _value = widget.initValue;

  void _updateValue(int newValue) {
    setState(() {
      _value = newValue;
    });

    widget.onChange(newValue);
    _controller.text = newValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTFNumPicker(
      width: _value.toString().length.toDouble() * 36,
      title: widget.title,
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter value';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 36.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
        textAlign: TextAlign.center,
        controller: _controller,
        onChanged: (value) {
          final _newValue = int.tryParse(value);
          if (_newValue != null) {
            setState(() {
              _value = _newValue;
            });
            widget.onChange(_newValue);
          }
        },
      ),
      onPressedLeftArrow: () {
        if (_value > 0) {
          var inputValue = _value - widget.changesByValue;

          _updateValue(inputValue);
        }
      },
      onPressedRightArrow: () {
        var inputValue = _value + widget.changesByValue;
        _updateValue(inputValue);
      },
      leftSubText: '${_value - widget.changesByValue}',
      rightSubText: '${_value + widget.changesByValue}',
      reachedZero: _value <= 0,
    );
  }
}
