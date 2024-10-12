class SetEntryDto {
  SetEntryDto({
    required this.id,
    required this.exerciseId,
    required this.exerciseType,
    required this.weight,
    required this.reps,
    required this.dateCreated,
  });
  final String id;
  final String exerciseId;
  final String exerciseType;
  final double weight;
  final int reps;
  final DateTime dateCreated;

  SetEntryDto copyWith({
    String? id,
    String? exerciseId,
    String? exerciseType,
    double? weight,
    int? reps,
    DateTime? dateCreated,
  }) {
    return SetEntryDto(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseType: exerciseType ?? this.exerciseType,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  factory SetEntryDto.fromMap(Map<String, dynamic> map) {
    return SetEntryDto(
      id: map['id'] as String,
      exerciseId: map['exerciseId'] as String,
      exerciseType: map['exerciseType'] as String,
      weight: map['weight'] as double,
      reps: map['reps'] as int,
      dateCreated: DateTime.parse(map['dateCreated'] as String),
    );
  }

  @override
  String toString() {
    return 'SetEntryDto(id: $id, exerciseID: $exerciseId, exerciseType: $exerciseType, weight: $weight, reps: $reps, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(covariant SetEntryDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exerciseId == exerciseId &&
        other.exerciseType == exerciseType &&
        other.weight == weight &&
        other.reps == reps &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        exerciseId.hashCode ^
        exerciseType.hashCode ^
        weight.hashCode ^
        reps.hashCode ^
        dateCreated.hashCode;
  }
}
