import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/decimal_text_field_number_picker.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/rpe_picker.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/text_field_number_picker.dart';

class CreateNewEntry extends ConsumerWidget {
  const CreateNewEntry({
    Key? key,
    required this.bottomButtons,
  }) : super(key: key);

  final Widget bottomButtons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        DecimalTextFieldNumPicker(
          title: 'WEIGHT',
          initValue: 0, // _createNewEntry.weight,
          onChange: (d) {}, // _createNewEntry.setWeightWithNewValue,
          changesByValue: 2.5,
        ),
        TextFieldNumberPicker(
          title: 'Reps',
          initValue: 12, // _createNewEntry.reps,
          onChange: (d) {}, // _createNewEntry.setRepsWithNewValue,
          changesByValue: 1,
        ),
        RPEPicker(
          value: 10, // _createNewEntry.rpe,
          onChanged: (d) {}, // _createNewEntry.setRPEWithNewValue,
        ),
        bottomButtons,
      ],
    );
  }
}
