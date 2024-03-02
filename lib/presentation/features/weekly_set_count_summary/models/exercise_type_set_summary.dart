class ExerciseTypeSetSummary {
  ExerciseTypeSetSummary({
    required this.exerciseType,
    required this.totalSets,
  });
  final String exerciseType;
  final int totalSets;

  @override
  bool operator ==(covariant ExerciseTypeSetSummary other) {
    if (identical(this, other)) return true;

    return other.exerciseType == exerciseType && other.totalSets == totalSets;
  }

  @override
  int get hashCode => exerciseType.hashCode ^ totalSets.hashCode;

  @override
  String toString() => 'ExerciseTypeSetSummary(exerciseType: $exerciseType, totalSets: $totalSets)';
}
