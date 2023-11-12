import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/base_tf_num_picker.dart';

class TextFieldNumberPicker extends ConsumerWidget {
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseTFNumPicker(
      width: initValue.toString().length.toDouble() * 36,
      title: title,
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
        controller: TextEditingController(text: initValue.toString()),
        onChanged: (value) {
          var inputValue = value.isEmpty ? 0 : int.tryParse(value);
          //context.read(createNewEntryProvider).repsSetter(inputValue!);
        },
        onFieldSubmitted: (value) {
          var inputValue = value.isEmpty ? 0.0 : double.parse(value);
          // context.read(createNewEntryProvider).setWeightWithNewValue(inputValue);
        },
      ),
      onPressedLeftArrow: () {
        if (initValue > 0) {
          var inputValue = initValue - changesByValue;
          onChange(inputValue);
        }
      },
      onPressedRightArrow: () {
        var inputValue = initValue + changesByValue;
        onChange(inputValue);
      },
      leftSubText: '${initValue - changesByValue}',
      rightSubText: '${initValue + changesByValue}',
      reachedZero: initValue > 0,
    );
  }
}
