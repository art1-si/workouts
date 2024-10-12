import 'package:workouts/data/dto_models/set_entry_dto.dart';

abstract interface class SetEntryDataSource {
  /// Adds a new set entry to the data source.
  ///
  /// - [exerciseId] is the id of the exercise the set entry is for.
  /// - [reps] is the number of reps in the set.
  /// - [weight] is the weight used in the set.
  /// returns the newly created set entry.
  Future<SetEntryDto> addSetEntry({required int exerciseId, required int reps, required int weight});

  /// Updates an existing set entry in the data source.
  ///
  /// - [id] is the id of the set entry to update.
  /// - [reps] is the new number of reps in the set. If null, the reps will not be updated.
  /// - [weight] is the new weight used in the set. If null, the weight will not be updated.
  /// returns the updated set entry.
  Future<SetEntryDto> updateSetEntry({required int id, int? reps, int? weight});

  /// Deletes a set entry from the data source.
  ///
  /// - [id] is the id of the set entry to delete.
  Future<void> deleteSetEntry({required int id});

  /// Gets all set entries from the data source.
  /// Allows for filtering by exercise id and date range.
  /// If no filters are provided, all set entries will be returned.
  Future<List<SetEntryDto>> getSetEntries({int? exerciseId, DateTime? startDate, DateTime? endDate});
}
