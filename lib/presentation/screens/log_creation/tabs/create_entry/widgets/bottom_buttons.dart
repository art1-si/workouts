import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/buttons/main_button.dart';

class RowWithBottomButtons extends ConsumerWidget {
  const RowWithBottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final _createEntry = watch(createNewEntryProvider);
//    final submitColor = _createEntry.editModeActive ? _theme.accentSecendery : _theme.accentPrimary;
    //  final resetColor = _theme.accentNegative;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainButton(
            onPressed: () {}, // _createEntry.handleOnTapSubmitEditButton,
            child: StyledText.button('Submit'), // _createEntry.editModeActive ? "Edit" : "Submit",
          ),
          MainButton(
            // disable: !_createEntry.editModeActive,
            onPressed: () {}, // _createEntry.handleOnTapDeleteOrReset,
            child: StyledText.button('Delete'),
          ),
        ],
      ),
    );
  }
}
