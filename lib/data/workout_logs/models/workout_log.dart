// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorkoutLog {
  WorkoutLog({
    required this.id,
    required this.exerciseID,
    required this.exerciseType,
    required this.weight,
    required this.reps,
    required this.dateCreated,
    required this.exerciseRPE,
  });
  final String id;
  final String exerciseID;
  final String exerciseType;
  final double weight;
  final int reps;
  final DateTime dateCreated;
  final int exerciseRPE;

  WorkoutLog copyWith({
    String? id,
    String? exerciseID,
    String? exerciseType,
    double? weight,
    int? reps,
    DateTime? dateCreated,
    int? exerciseRPE,
  }) {
    return WorkoutLog(
      id: id ?? this.id,
      exerciseID: exerciseID ?? this.exerciseID,
      exerciseType: exerciseType ?? this.exerciseType,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      dateCreated: dateCreated ?? this.dateCreated,
      exerciseRPE: exerciseRPE ?? this.exerciseRPE,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'exerciseID': exerciseID,
      'exerciseType': exerciseType,
      'weight': weight,
      'reps': reps,
      'dateCreated': dateCreated.toIso8601String(),
      'exerciseRPE': exerciseRPE,
    };
  }

  factory WorkoutLog.fromMap(Map<String, dynamic> map) {
    return WorkoutLog(
      id: map['id'] as String,
      exerciseID: map['exerciseID'] as String,
      exerciseType: map['exerciseType'] as String,
      weight: map['weight'] as double,
      reps: map['reps'] as int,
      dateCreated: DateTime.parse(map['dateCreated'] as String),
      exerciseRPE: map['exerciseRPE'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutLog.fromJson(String source) => WorkoutLog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkoutLog(id: $id, exerciseID: $exerciseID, exerciseType: $exerciseType, weight: $weight, reps: $reps, dateCreated: $dateCreated, exerciseRPE: $exerciseRPE)';
  }

  @override
  bool operator ==(covariant WorkoutLog other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exerciseID == exerciseID &&
        other.exerciseType == exerciseType &&
        other.weight == weight &&
        other.reps == reps &&
        other.dateCreated == dateCreated &&
        other.exerciseRPE == exerciseRPE;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        exerciseID.hashCode ^
        exerciseType.hashCode ^
        weight.hashCode ^
        reps.hashCode ^
        dateCreated.hashCode ^
        exerciseRPE.hashCode;
  }
}
