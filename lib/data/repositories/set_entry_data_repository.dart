import 'package:workouts/data/sources/set_entry_data_source/set_entry_data_source.dart';
import 'package:workouts/domain/entities/set_entry.dart';
import 'package:workouts/domain/repositories/set_entry_repository.dart';

class SetEntryDataRepository implements SetEntryRepository {
  SetEntryDataRepository({
    required SetEntryDataSource setEntryDataSource,
  }) : _setEntryDataSource = setEntryDataSource;

  final SetEntryDataSource _setEntryDataSource;

  @override
  Future<SetEntry> addSetEntry({required SetEntry setEntry}) {
    // TODO: implement addSetEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSetEntry({required int setEntryId}) {
    // TODO: implement deleteSetEntry
    throw UnimplementedError();
  }

  @override
  Future<List<SetEntry>> getSetEntries({DateTime? startDate, DateTime? endDate}) {
    // TODO: implement getSetEntries
    throw UnimplementedError();
  }

  @override
  Future<List<SetEntry>> getSetEntriesPerExercise({required int exerciseId, DateTime? startDate, DateTime? endDate}) {
    // TODO: implement getSetEntriesPerExercise
    throw UnimplementedError();
  }

  @override
  Future<SetEntry> updateSetEntry({required int setEntryId, double? weight, int? reps}) {
    // TODO: implement updateSetEntry
    throw UnimplementedError();
  }
}
