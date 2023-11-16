import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/base_tf_num_picker.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class DecimalTextFieldNumPicker extends StatefulWidget {
  const DecimalTextFieldNumPicker({
    Key? key,
    required this.title,
    required this.initValue,
    required this.onChange,
    required this.changesByValue,
  }) : super(key: key);

  final String title;
  final double initValue;
  final ValueChanged<double> onChange;
  final double changesByValue;

  @override
  State<DecimalTextFieldNumPicker> createState() => _DecimalTextFieldNumPickerState();
}

class _DecimalTextFieldNumPickerState extends State<DecimalTextFieldNumPicker> {
  late final _controller = TextEditingController(text: widget.initValue.toString());
  late double _value = widget.initValue;

  void _updateValue(double newValue) {
    setState(() {
      _value = newValue;
    });

    widget.onChange(newValue);
    _controller.text = newValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    final _tfWidth = _value.toString().length.toDouble() < 3 ? 3 * 45 : (_value.toString().length.toDouble() - 1) * 36;
    return BaseTFNumPicker(
      width: _tfWidth as double,
      title: widget.title,
      child: TextFormField(
        cursorColor: AppColors.primaryShades.shade80,
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
          final _newValue = double.tryParse(value);
          if (_newValue != null) {
            setState(() {
              _value = _newValue;
            });
            widget.onChange(_newValue);
          }
        },
      ),
      onPressedLeftArrow: () {
        if (widget.initValue > 0) {
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
