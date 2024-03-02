import 'package:flutter/material.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/widgets/graph_widget/controller/graph_offset_point.dart';

typedef GraphElement<XAxisT> = ({double yAxis, XAxisT xAxis});

class GraphViewController<XAxisT> {
  GraphViewController({
    required List<GraphElement<XAxisT>> graphElements,
  })  : _greatestValue = _getGreatestValue<XAxisT>(graphElements),
        _smallestValue = _getSmallestValue<XAxisT>(graphElements) {
    _graphOffsetPoints = _calculateGraphOffsetPoints<XAxisT>(
      graphElements,
      smallestValue,
      greatestValue,
    );
    _trendGraphOffsetPoints = _calculateMovingAverageTrendPoints(graphElements, 6);
  }

  late final List<GraphOffsetPoint> _graphOffsetPoints;
  late final List<GraphOffsetPoint> _trendGraphOffsetPoints;

  final double _greatestValue;
  final double _smallestValue;

  final ValueNotifier<int?> pressedElementIndex = ValueNotifier(null);

  double get greatestValue => _greatestValue;
  double get smallestValue => _smallestValue - (0.10 * _smallestValue);

  List<GraphOffsetPoint> get graphOffsetPoints => _graphOffsetPoints;
  List<GraphOffsetPoint> get trendGraphOffsetPoints => _trendGraphOffsetPoints;

  static double calculateTrend(List<double> values) {
    final n = values.length;
    final meanX = (n - 1) / 2; // Since x values are from 0 to n-1, mean is (n-1)/2
    final meanY = values.reduce((a, b) => a + b) / n;

    var numerator = 0.0;
    var denominator = 0.0;

    for (var i = 0; i < n; i++) {
      numerator += (i - meanX) * (values[i] - meanY);
      denominator += (i - meanX) * (i - meanX);
    }

    return numerator / denominator; // This is the slope of the trend line
  }

  /// Returns the graph offset points.
  static List<GraphOffsetPoint> _calculateGraphOffsetPoints<XAxisT>(
      List<GraphElement<XAxisT>> graphElements, double smallestValue, double greatestValue) {
    final graphOffsetPoints = <GraphOffsetPoint>[];
    final xPointsDistance = 1 / (graphElements.length - 1);
    var xAxis = 0.0;
    for (var i = 0; i < graphElements.length; i++) {
      var point = graphElements[i];
      var relativeYPosition = _getRelativeYposition(
        value: point.yAxis,
        smallestValue: smallestValue,
        greatestValue: greatestValue,
      );
      graphOffsetPoints.add(
        GraphOffsetPoint(
          xAxis: xAxis,
          yAxis: relativeYPosition,
        ),
      );
      xAxis += xPointsDistance;
    }
    return graphOffsetPoints;
  }

  List<GraphOffsetPoint> _calculateMovingAverageTrendPoints(List<GraphElement<XAxisT>> graphElements, int windowSize) {
    final movingAveragePoints = <GraphOffsetPoint>[];
    final yValues = graphElements.map((e) => e.yAxis).toList();
    final xPointsDistance = 1 / (graphElements.length - 1);
    var xAxis = 0.0;

    // Calculate moving average for each point, considering the window size
    for (var i = 0; i < yValues.length; i++) {
      var start = i - windowSize ~/ 2;
      var end = i + windowSize ~/ 2;
      start = start < 0 ? 0 : start;
      end = end > yValues.length - 1 ? yValues.length - 1 : end;

      var sum = 0.0;
      for (var j = start; j <= end; j++) {
        sum += yValues[j];
      }
      var average = sum / (end - start + 1);

      var relativeYPosition = _getRelativeYposition(
        value: average,
        smallestValue: smallestValue,
        greatestValue: greatestValue,
      );

      movingAveragePoints.add(GraphOffsetPoint(xAxis: xAxis, yAxis: relativeYPosition));
      xAxis += xPointsDistance;
    }

    return movingAveragePoints;
  }

  void resetPressedElementIndex() {
    pressedElementIndex.value = null;
  }

  /// Returns the relative Y position of the graph element.
  static double _getRelativeYposition({
    required double value,
    required double smallestValue,
    required double greatestValue,
  }) {
    var relativeValue = value - smallestValue;
    var relativeGreatestValue = greatestValue - smallestValue;
    return 1 - (relativeValue / relativeGreatestValue);
  }

  /// Returns the greatest value in the graph elements.
  static double _getGreatestValue<XAxisT>(List<GraphElement<XAxisT>> graphElements) {
    var greatestValue = 0.0;
    for (var point in graphElements) {
      if (point.yAxis > greatestValue) {
        greatestValue = point.yAxis;
      }
    }
    return greatestValue;
  }

  /// Returns the smallest value in the graph elements.
  static double _getSmallestValue<XAxisT>(List<GraphElement<XAxisT>> graphElements) {
    var smallestValue = 1000000.0;
    for (var point in graphElements) {
      if (point.yAxis < smallestValue) {
        smallestValue = point.yAxis;
      }
    }
    return smallestValue;
  }

  void setPressElementIndexOnPressedOffset(Offset offset) {
    final xPointsDistance = _getXPointsDistance();
    var halfDistance = xPointsDistance / 2;

    late final int index;
    if (offset.dx < 0) {
      index = 0;
      return;
    }
    for (var i = 0; i < _graphOffsetPoints.length; i++) {
      var point = _graphOffsetPoints[i];
      final isLast = i == _graphOffsetPoints.length - 1;

      if (isLast && (offset.dx + halfDistance) >= point.xAxis) {
        index = i;
        break;
      }

      if ((offset.dx + halfDistance) < (point.xAxis + xPointsDistance) && (offset.dx + halfDistance) >= point.xAxis) {
        index = i;
        break;
      }
    }
    pressedElementIndex.value = index;
  }

  double _getXPointsDistance() {
    if (_graphOffsetPoints.isEmpty || _graphOffsetPoints.length == 1) {
      return 0;
    }
    return 1 / (_graphOffsetPoints.length - 1);
  }
}
