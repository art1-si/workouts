import 'dart:convert';

class ExerciseDto {
  final int id;
  final String name;
  final String type;
  ExerciseDto({
    required this.id,
    required this.name,
    required this.type,
  });

  ExerciseDto copyWith({
    int? id,
    String? name,
    String? type,
  }) {
    return ExerciseDto(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory ExerciseDto.fromMap(Map<String, dynamic> map) {
    return ExerciseDto(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseDto.fromJson(String source) => ExerciseDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ExerciseDto(id: $id, name: $name, type: $type)';

  @override
  bool operator ==(covariant ExerciseDto other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}
