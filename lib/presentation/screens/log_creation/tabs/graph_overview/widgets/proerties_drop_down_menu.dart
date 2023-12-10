import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/services/graph_selector_provider.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class PropertiesDropDown extends StatefulWidget {
  const PropertiesDropDown({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final GraphProperties initialValue;
  final void Function(GraphProperties) onChanged;

  @override
  State<PropertiesDropDown> createState() => _PropertiesDropDownState();
}

class _PropertiesDropDownState extends State<PropertiesDropDown> {
  late GraphProperties _value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<GraphProperties>(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.primaryShades.shade70,
        ),
        iconSize: 24,
        elevation: 0,
        alignment: AlignmentDirectional.topCenter,
        underline: Container(),
        isExpanded: true,
        dropdownColor: AppColors.primaryShades.shade90,
        value: _value,
        onChanged: (GraphProperties? newValue) {
          setState(() {
            _value = newValue!;
            widget.onChanged(newValue);
          });
        },
        items: GraphProperties.values.map((GraphProperties properties) {
          return DropdownMenuItem<GraphProperties>(
            value: properties,
            child: StyledText.body(
              properties.propertiesToString(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
