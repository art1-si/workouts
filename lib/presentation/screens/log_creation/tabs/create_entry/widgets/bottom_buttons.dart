import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/workout_logs/workout_logs_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/new_entry_controller.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/buttons/secondary_button.dart';

class RowWithBottomButtons extends ConsumerWidget {
  const RowWithBottomButtons({
    Key? key,
    this.editModeActive = false,
    required this.newEntryMediator,
  }) : super(key: key);

  final bool editModeActive;
  final NewEntryMediator newEntryMediator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SecondaryButton(
              color: AppColors.primaryShades.shade70,
              onPressed: () async {
                editModeActive
                    ? await ref.read(workoutLogControllerProvider.notifier).updateLog(newEntryMediator.workoutLog)
                    : await ref.read(workoutLogControllerProvider.notifier).addLog(newEntryMediator.workoutLog);
              }, // _createEntry.handleOnTapSubmitEditButton,
              child: StyledText.button(
                editModeActive ? 'Edit' : 'Submit',
                color: AppColors.primaryShades.shade100,
              ), // _createEntry.editModeActive ? "Edit" : "Submit",
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SecondaryButton(
              disabled: !editModeActive,
              color: AppColors.primaryShades.shade80,
              // disable: !_createEntry.editModeActive,
              onPressed: () async {
                await ref.read(workoutLogControllerProvider.notifier).deleteLog(newEntryMediator.workoutLog);
              }, // _createEntry.handleOnTapDeleteOrReset,
              child: StyledText.button('Delete'),
            ),
          ),
        ],
      ),
    );
  }
}
