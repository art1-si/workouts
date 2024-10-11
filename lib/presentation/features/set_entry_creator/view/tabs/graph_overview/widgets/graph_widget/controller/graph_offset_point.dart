class GraphOffsetPoint {
  GraphOffsetPoint({
    required this.xAxis,
    required this.yAxis,
  });
  final double xAxis;
  final double yAxis;

  GraphOffsetPoint copyWith({
    double? xAxis,
    double? yAxis,
  }) {
    return GraphOffsetPoint(
      xAxis: xAxis ?? this.xAxis,
      yAxis: yAxis ?? this.yAxis,
    );
  }

  @override
  String toString() => 'GraphPoint(xAxis: $xAxis, yAxis: $yAxis)';

  @override
  bool operator ==(covariant GraphOffsetPoint other) {
    if (identical(this, other)) return true;

    return other.xAxis == xAxis && other.yAxis == yAxis;
  }

  @override
  int get hashCode => xAxis.hashCode ^ yAxis.hashCode;
}
