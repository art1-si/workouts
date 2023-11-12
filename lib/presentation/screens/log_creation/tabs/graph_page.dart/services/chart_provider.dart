// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_notes_app/data_models/exercise_log.dart';
// import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_selector_provider.dart';
// import 'package:workout_notes_app/services/1rm_formula.dart';

// final chartViewProvider = Provider.autoDispose<ChartViewModel>((ref) {
//   final _log = ref.watch(exerciseLogProvider);
//   final _graphSelector = ref.watch(graphSelector);
//   return ChartViewModel(
//     exerciseLog: _log,
//     properties: _graphSelector.graphProperties,
//   );
// });

// class ChartViewModel {
//   ChartViewModel({required this.exerciseLog, required this.properties}) {
//     _setMinAndMaxValue();
//     _findOffsets();
//   }

//   final List<ExerciseLog> exerciseLog;
//   final GraphProperties properties;

//   List<GraphModel>? _graphPoints;
//   double _minValue = 0;
//   double _maxValue = 0;

//   double get maxValue => _maxValue;
//   double get minValue => _minValue;
//   List<GraphModel>? get graphPoints => _graphPoints;

//   double _getGraphValueToPropertie(ExerciseLog log) {
//     late final _element;
//     switch (properties) {
//       case GraphProperties.perWeight:
//         _element = log.weight;
//         break;
//       case GraphProperties.oneRepMax:
//         _element = epleyCalOneRepMax(log.weight, log.reps);
//         break;
//       case GraphProperties.simpleVolumePerSet:
//         _element = log.weight * log.reps;
//         break;
//     }
//     return _element;
//   }

//   void _findOffsets() {
//     _setMinAndMaxValue();
//     var _results = <GraphModel>[];
//     final double width = 1.0;
//     bool isLast = false;
//     double distance = 0.07; //!may couse bugs in graph layout part 1
//     double nextDistance = (width - 0.1) / (exerciseLog.length - 1);
//     int nextValueIndex = 1;
//     exerciseLog.forEach((log) {
//       final _valueToProperty = _getGraphValueToPropertie(log);
//       double nextValue = exerciseLog.length > nextValueIndex
//           ? _getGraphValueToPropertie(exerciseLog[nextValueIndex])
//           : _valueToProperty;

//       double _yPosition = _getRelativeYposition(value: _valueToProperty);
//       double _nextYPosition = _getRelativeYposition(value: nextValue);
//       _results.add(
//         GraphModel(
//           x: distance,
//           nextX: isLast ? distance : distance + nextDistance,
//           y: _yPosition,
//           nextY: _nextYPosition,
//           corespondingLog: log,
//         ),
//       );

//       nextValueIndex++;
//       isLast = exerciseLog.length == nextValueIndex;
//       distance = distance + nextDistance;
//     });
//     _graphPoints = _results;
//   }

//   double _getRelativeYposition({
//     required double value,
//   }) {
//     double height = 1.0;

//     double relativeYposition = (value - minValue) / (maxValue - minValue);
//     double yOffset = height - relativeYposition * height;

//     return yOffset;
//   }

//   void _setMinAndMaxValue() {
//     if (exerciseLog.length > 1) {
//       exerciseLog.forEach((element) {
//         final _value = _getGraphValueToPropertie(element);
//         if (_value > _maxValue) {
//           _maxValue = _value;
//         }
//         /* if (_value < _minValue) {
//           _minValue = _value;
//         } */
//       });
//     } else if (exerciseLog.isNotEmpty && exerciseLog.length < 2) {
//       _maxValue = exerciseLog.first.weight * 2;

//       _minValue = 0;
//     }
//   }
// }
