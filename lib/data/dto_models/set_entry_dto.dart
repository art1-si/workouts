import 'dart:convert';

class SetEntryDto {
  SetEntryDto({
    required this.id,
    required this.exerciseId,
    required this.weight,
    required this.reps,
    required this.createdAt,
    required this.updatedAt,
  });
  final int id;
  final int exerciseId;
  final double weight;
  final int reps;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SetEntryDto copyWith({
    int? id,
    int? exerciseId,
    double? weight,
    int? reps,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SetEntryDto(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'exerciseId': exerciseId,
      'weight': weight,
      'reps': reps,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory SetEntryDto.fromMap(Map<String, dynamic> map) {
    return SetEntryDto(
      id: map['id'] as int,
      exerciseId: map['exerciseId'] as int,
      weight: map['weight'] as double,
      reps: map['reps'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetEntryDto.fromJson(String source) => SetEntryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SetEntryDto(id: $id, exerciseId: $exerciseId, weight: $weight, reps: $reps, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SetEntryDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exerciseId == exerciseId &&
        other.weight == weight &&
        other.reps == reps &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        exerciseId.hashCode ^
        weight.hashCode ^
        reps.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
