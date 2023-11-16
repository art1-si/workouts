import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/new_entry_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/decimal_text_field_number_picker.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/rpe_picker.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/widgets/text_field_number_picker.dart';

class CreateNewEntry extends StatelessWidget {
  const CreateNewEntry({
    Key? key,
    required this.newEntryController,
  }) : super(key: key);

  final NewEntryMediator newEntryController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: newEntryController.editableWorkoutLog,
        builder: (context, child) {
          return Column(
            children: <Widget>[
              DecimalTextFieldNumPicker(
                key: ValueKey(newEntryController.weight),
                title: 'WEIGHT',
                initValue: newEntryController.weight,
                onChange: newEntryController.setWeightWithNewValue,
                //TODO(Artur):Make this as exercise setting
                changesByValue: 2.5,
              ),
              TextFieldNumberPicker(
                key: ValueKey(newEntryController.reps),
                title: 'Reps',
                initValue: newEntryController.reps,
                onChange: newEntryController.setRepsWithNewValue,
                changesByValue: 1,
              ),
              RPEPicker(
                key: ValueKey(newEntryController.rpe),
                initValue: newEntryController.rpe,
                onChanged: newEntryController.setRPEWithNewValue,
              ),
            ],
          );
        });
  }
}
