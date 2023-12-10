// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Exercise {
  final String id;
  final String exerciseName;
  final String exerciseType;
  Exercise({
    required this.id,
    required this.exerciseName,
    required this.exerciseType,
  });

  factory Exercise.unknown() {
    return Exercise(
      id: 'unknown',
      exerciseName: 'unknown',
      exerciseType: 'unknown',
    );
  }

  Exercise copyWith({
    String? id,
    String? exerciseName,
    String? exerciseType,
  }) {
    return Exercise(
      id: id ?? this.id,
      exerciseName: exerciseName ?? this.exerciseName,
      exerciseType: exerciseType ?? this.exerciseType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'exerciseName': exerciseName,
      'exerciseType': exerciseType,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as String,
      exerciseName: map['exerciseName'] as String,
      exerciseType: map['exerciseType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) => Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Exercise(id: $id, exerciseName: $exerciseName, exerciseType: $exerciseType)';

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;

    return other.id == id && other.exerciseName == exerciseName && other.exerciseType == exerciseType;
  }

  @override
  int get hashCode => id.hashCode ^ exerciseName.hashCode ^ exerciseType.hashCode;
}
