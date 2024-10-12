class SetEntry {
  SetEntry({
    required this.id,
    required this.weight,
    required this.reps,
    required this.dateCreated,
  });
  final String id;
  final double weight;
  final int reps;
  final DateTime dateCreated;

  SetEntry copyWith({
    String? id,
    double? weight,
    int? reps,
    DateTime? dateCreated,
  }) {
    return SetEntry(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  String toString() {
    return 'SetEntry(id: $id, weight: $weight, reps: $reps, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(covariant SetEntry other) {
    if (identical(this, other)) return true;

    return other.id == id && other.weight == weight && other.reps == reps && other.dateCreated == dateCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^ weight.hashCode ^ reps.hashCode ^ dateCreated.hashCode;
  }
}
