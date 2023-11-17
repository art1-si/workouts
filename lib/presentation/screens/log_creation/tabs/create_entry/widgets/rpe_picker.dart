import 'package:flutter/material.dart';
import 'package:workouts/presentation/theme/typography.dart';

typedef void VoidIntCallback(int i);

class RPEPicker extends StatefulWidget {
  const RPEPicker({
    Key? key,
    required this.onChanged,
    required this.initValue,
  }) : super(key: key);
  final ValueChanged<int> onChanged;
  final int initValue;

  static const List<int> _rpePicker = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  State<RPEPicker> createState() => _RPEPickerState();
}

class _RPEPickerState extends State<RPEPicker> {
  late int _value = widget.initValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: SizedBox(
        height: 90,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StyledText.labelMedium('RPE'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: RPEPicker._rpePicker
                  .map(
                    (rpe) => _Item(
                      onPressed: (value) {
                        setState(() {
                          _value = value;
                        });
                        widget.onChanged(_value);
                      },
                      //TODO(Artur): change color based on theme
                      selectedColor: Colors.green,
                      rpe: rpe,
                      selected: rpe == _value,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.rpe,
    required this.selected,
    required this.selectedColor,
    required this.onPressed,
  }) : super(key: key);
  final int rpe;
  final bool selected;
  final Color selectedColor;
  final VoidIntCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final _width = (MediaQuery.of(context).size.width - 16) / 10;
    return GestureDetector(
      onTap: () => onPressed(rpe),
      child: AnimatedContainer(
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: selected ? Border.all(color: selectedColor.withOpacity(0.2)) : null,
          color: selected ? selectedColor.withOpacity(0.1) : null,
        ),
        duration: const Duration(milliseconds: 250),
        child: SizedBox(
          height: 40,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                  fontSize: selected ? 24 : 14,
                  color: selected ? selectedColor.withOpacity(0.7) : Colors.white54,
                  fontWeight: selected ? FontWeight.bold : null),
              child: Text(
                rpe.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}