import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'exerciseName': name,
      'exerciseType': type,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) => Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

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
