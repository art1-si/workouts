import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/application/exercises/user_define_exercises_controller.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/buttons/secondary_button.dart';

class ExerciseCreationModal extends ConsumerStatefulWidget {
  const ExerciseCreationModal({Key? key, required this.existingExercises}) : super(key: key);
  final List<Exercise> existingExercises;

  @override
  ConsumerState<ExerciseCreationModal> createState() => _ExerciseCreationModalState();
}

class _ExerciseCreationModalState extends ConsumerState<ExerciseCreationModal> {
  final _formKey = GlobalKey<FormState>();

  Set<String> get existingTypes {
    return widget.existingExercises.map((exercise) => exercise.exerciseType).toSet();
  }

  String? _exerciseType;
  String? _exerciseName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: StyledText.labelLarge('Create Exercise'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: WorkoutsPrimaryTextField(
                labelText: 'Exercise Name',
                onChanged: (value) {
                  _exerciseName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  final existingExercise = widget.existingExercises.firstWhereOrNull(
                    (exercise) => exercise.exerciseName.toLowerCase() == value.toLowerCase(),
                  );

                  if (existingExercise != null) {
                    return 'Exercise already exists';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpendableDropDownMenuTextField(
                labelText: 'Exercise Type',
                items: existingTypes.toList(),
                onChanged: (value) {
                  _exerciseType = value;
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
              child: SecondaryButton(
                color: AppColors.primaryShades.shade70,
                child: StyledText.button('SAVE', color: AppColors.primaryShades.shade100),
                onPressed: () async {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    await ref.read(userDefineExercisesControllerProvider.notifier).createExercise(
                          exerciseName: _exerciseName!,
                          exerciseType: _exerciseType!,
                        );
                    context.pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpendableDropDownMenuTextField extends StatefulWidget {
  const ExpendableDropDownMenuTextField({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
  });

  final List<String> items;

  final String labelText;
  final void Function(String)? onChanged;

  @override
  State<ExpendableDropDownMenuTextField> createState() => _ExpendableDropDownMenuTextFieldState();
}

class _ExpendableDropDownMenuTextFieldState extends State<ExpendableDropDownMenuTextField> {
  final textController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  bool _expanded = false;

  List<String> get _filteredItems {
    return widget.items.where((element) => element.toLowerCase().contains(textController.text.toLowerCase())).toList();
  }

  void textControllerListener() {
    widget.onChanged?.call(textController.text);
    setState(() {});
  }

  void focusNodeListener() {
    if (textFieldFocusNode.hasFocus && !_expanded) {
      setState(() {
        _expanded = true;
      });
      return;
    }

    if (!textFieldFocusNode.hasFocus && _expanded) {
      setState(() {
        _expanded = false;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(focusNodeListener);
    textController.addListener(textControllerListener);
  }

  @override
  void dispose() {
    textFieldFocusNode.removeListener(focusNodeListener);
    textController.removeListener(textControllerListener);
    super.dispose();
  }

  late final _textField = WorkoutsPrimaryTextField(
    labelText: widget.labelText,
    controller: textController,
    focusNode: textFieldFocusNode,
    textFieldKey: const Key('ExpendableDropDownMenuTextField'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a type';
      }
      return null;
    },
  );

  final _textFieldHeight = 65.0;
  final _itemHeight = 35.0;

  @override
  Widget build(BuildContext context) {
    final containerHeight = _expanded ? (_filteredItems.length * _itemHeight) + _textFieldHeight : _textFieldHeight;
    return AnimatedContainer(
      height: containerHeight,
      duration: const Duration(milliseconds: 250),
      child: Column(
        children: [
          _textField,
          if (_expanded)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StatefulBuilder(builder: (context, setState) {
                  return ListView(
                    shrinkWrap: true,
                    children: _filteredItems
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              textController.text = e;
                              setState(() {
                                _expanded = false;
                                textFieldFocusNode.unfocus();
                              });
                            },
                            child: Container(
                              height: _itemHeight,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: StyledText.labelMedium(e),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class WorkoutsPrimaryTextField extends StatelessWidget {
  const WorkoutsPrimaryTextField({
    super.key,
    required this.labelText,
    this.validator,
    this.controller,
    this.focusNode,
    this.textFieldKey,
    this.onChanged,
  });
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Key? textFieldKey;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        key: textFieldKey,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
