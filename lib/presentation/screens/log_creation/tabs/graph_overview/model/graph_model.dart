class GraphModel<T> {
  GraphModel({
    required this.x,
    required this.nextX,
    required this.nextY,
    required this.y,
    required this.data,
    required this.correspondingValue,
  });
  final double x;
  final double nextX;
  final double y;
  final double nextY;
  final T data;
  final double correspondingValue;
}
