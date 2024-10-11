class Exercise {
  final int id;
  final String name;
  final String type;
  Exercise({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Exercise.unknown() {
    return Exercise(
      id: -1,
      name: 'unknown',
      type: 'unknown',
    );
  }

  Exercise copyWith({
    int? id,
    String? name,
    String? type,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  String toString() => 'Exercise(id: $id, exerciseName: $name, exerciseType: $type)';

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}
