import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../lib.old/application/workout_logs/workout_logs_controller.dart';
import '../new_entry_controller.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../theme/typography.dart';
import '../../../../../../../../lib.old/presentation/widgets/buttons/secondary_button.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
