import 'dart:ui';

import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/model/graph_model.dart';

class GraphViewController<T> {
  GraphViewController({required this.data, required this.valueYGetter}) {
    _setMinAndMaxValue();
    _findOffsets();
  }

  final List<T> data;
  final double Function(T) valueYGetter;

  late final List<GraphModel<T>> _graphPoints;
  double _minValue = 1000000;
  double _maxValue = 0;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  List<GraphModel> get graphPoints => _graphPoints;
  GraphModel<T>? get pressedElement => _pressedElement;

  GraphModel<T>? _pressedElement;

  void resetPressedElement() {
    _pressedElement = null;
  }

  void setTappedEntryByOffset(Offset offset) {
    _compereOffset(offset);
  }

  void _compereOffset(Offset offset) {
    var distance = _graphPoints.first.nextX - _graphPoints.first.x;
    var halfDistance = ((_graphPoints.first.nextX - _graphPoints.first.x) / 2);
    for (var i = 0; i < _graphPoints.length; i++) {
      var point = _graphPoints[i];
      if (offset.dx + halfDistance < (point.x + distance) && offset.dx + halfDistance >= point.x) {
        _pressedElement = point;
      }
    }
  }

  void _findOffsets() {
    _setMinAndMaxValue();
    var _results = <GraphModel<T>>[];
    final width = 1.0;
    var isLast = false;
    var distance = 0.12; //!may couse bugs in graph layout part 1
    var nextDistance = (width - 0.12) / (data.length - 1);
    var nextValueIndex = 1;
    for (var element in data) {
      final _valueToProperty = valueYGetter(element);
      var nextValue = data.length > nextValueIndex ? valueYGetter(data[nextValueIndex]) : _valueToProperty;

      var _yPosition = _getRelativeYposition(value: _valueToProperty);
      var _nextYPosition = _getRelativeYposition(value: nextValue);
      _results.add(
        GraphModel(
          x: distance,
          nextX: isLast ? distance : distance + nextDistance,
          y: _yPosition,
          nextY: _nextYPosition,
          data: element,
        ),
      );

      nextValueIndex++;
      isLast = data.length == nextValueIndex;
      distance = distance + nextDistance;
    }
    _graphPoints = _results;
  }

  double _getRelativeYposition({
    required double value,
  }) {
    var height = 1.0;

    var relativeYposition = (value - minValue) / (maxValue - minValue);
    var yOffset = height - relativeYposition * height;

    return yOffset;
  }

  void _setMinAndMaxValue() {
    if (data.length > 1) {
      for (var element in data) {
        final _value = valueYGetter(element);
        if (_value < _minValue) {
          _minValue = _value;
        }
        if (_value > _maxValue) {
          _maxValue = _value;
        }
        /* if (_value < _minValue) {
          _minValue = _value;
        } */
      }
    } else if (data.isNotEmpty && data.length < 2) {
      _maxValue = valueYGetter(data.first) * 2;

      _minValue = 0;
    }
  }
}

// class DetailsProvider extends ChangeNotifier {
//   DetailsProvider(this.properties);

//   GraphModel? _log;
//   Offset? _offset;
//   int? _index;
//   List<GraphModel>? points;

//   //double? width;

//   GraphModel? get logDetails => _log ?? points?.lastOrNull;
//   int? get index => _index;
//   Offset? get offset => _offset;

//   void setOffset(Offset? offset) {
//     _offset = offset;
//     _compereOffset();
//   }

//   void _setDetails(GraphModel? value) {
//     _log = value;
//     notifyListeners();
//   }

//   double? pointedValue() {
//     double? _value;
//     switch (properties) {
//       case GraphProperties.perWeight:
//         break;
//       case GraphProperties.oneRepMax:
//         _value = epleyCalOneRepMax(logDetails!.correspondingLog.weight, logDetails!.correspondingLog.reps);
//         break;
//       case GraphProperties.simpleVolumePerSet:
//         _value = logDetails!.correspondingLog.weight * logDetails!.correspondingLog.reps;
//         break;
//     }
//     return _value;
//   }

//   void _compereOffset() {
//     if (_offset != null) {
//       var distance = points!.first.nextX - points!.first.x;
//       var halfDistance = (points!.first.nextX - points!.first.x) / 2;
//       for (var i = 0; i < points!.length; i++) {
//         var point = points![i];
//         if (_offset!.dx + halfDistance < (point.x + distance) && _offset!.dx + halfDistance >= point.x) {
//           _index = i;
//           if (_log != point) {
//             _setDetails(point);
//           }
//         }
//       }
//     } else {
//       _setDetails(null);
//       _index = null;
//     }
//   }
// }
