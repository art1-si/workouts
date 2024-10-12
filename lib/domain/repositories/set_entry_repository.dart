import 'package:workouts/domain/entities/set_entry.dart';

abstract interface class SetEntryRepository {
  /// Returns a list of all recorded set entries for current user.
  /// [startDate] is the start date of the range to query. If null, all entries are returned.
  /// [endDate] is the end date of the range to query. If null, all entries are returned.
  Future<List<SetEntry>> getSetEntries({DateTime? startDate, DateTime? endDate});

  /// Returns a list of recorded set entries for [exerciseId].
  /// [startDate] is the start date of the range to query. If null, all entries are returned.
  /// [endDate] is the end date of the range to query. If null, all entries are returned.
  Future<List<SetEntry>> getSetEntriesPerExercise({required int exerciseId, DateTime? startDate, DateTime? endDate});

  /// Adds a new set entry to the data source.
  /// [exerciseId] is the ID of the exercise the set entry is for.
  /// [reps] is the number of reps in the set.
  /// [weight] is the weight used in the set.
  /// Returns the newly added set entry.
  Future<SetEntry> addSetEntry({required int exerciseId, required int reps, required double weight});

  /// Updates an existing set entry in the data source.
  /// [setEntryId] is the ID of the set entry to update.
  /// [weight] is the new weight value. If null, the existing value is preserved.
  /// [reps] is the new reps value. If null, the existing value is preserved.
  /// Returns the updated set entry.
  Future<SetEntry> updateSetEntry({required int setEntryId, double? weight, int? reps});

  /// Deletes a set entry from the data source.
  /// [setEntryId] is the ID of the set entry to delete.
  Future<void> deleteSetEntry({required int setEntryId});
}
