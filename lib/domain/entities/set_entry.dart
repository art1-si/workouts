class SetEntry {
  SetEntry({
    required this.id,
    required this.exerciseId,
    required this.weight,
    required this.reps,
    required this.dateCreated,
  });
  final int id;
  final int exerciseId;
  final double weight;
  final int reps;
  final DateTime dateCreated;

  SetEntry copyWith({
    int? id,
    int? exerciseId,
    double? weight,
    int? reps,
    DateTime? dateCreated,
  }) {
    return SetEntry(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  String toString() {
    return 'SetEntry(id: $id, exerciseId: $exerciseId, weight: $weight, reps: $reps, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(covariant SetEntry other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exerciseId == exerciseId &&
        other.weight == weight &&
        other.reps == reps &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^ exerciseId.hashCode ^ weight.hashCode ^ reps.hashCode ^ dateCreated.hashCode;
  }
}
