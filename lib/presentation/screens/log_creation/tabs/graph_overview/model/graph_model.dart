class GraphModel<T> {
  GraphModel({
    required this.x,
    required this.nextX,
    required this.nextY,
    required this.y,
    required this.data,
  });
  final double x;
  final double nextX;
  final double y;
  final double nextY;
  final T data;
}
