import 'package:workouts/data/dto_models/set_entry_dto.dart';
import 'package:workouts/data/sources/set_entry_data_source/set_entry_data_source.dart';
import 'package:workouts/domain/entities/set_entry.dart';
import 'package:workouts/domain/repositories/set_entry_repository.dart';

extension ToSetEntryEntity on SetEntryDto {
  SetEntry toSetEntryEntity() {
    return SetEntry(
      id: id,
      exerciseId: exerciseId,
      weight: weight,
      reps: reps,
      dateCreated: createdAt,
    );
  }
}

class SetEntryDataRepository implements SetEntryRepository {
  SetEntryDataRepository({
    required SetEntryDataSource setEntryDataSource,
  }) : _setEntryDataSource = setEntryDataSource;

  final SetEntryDataSource _setEntryDataSource;

  @override
  Future<SetEntry> addSetEntry({required int exerciseId, required int reps, required double weight}) async {
    final setEntryDto = await _setEntryDataSource.addSetEntry(exerciseId: exerciseId, reps: reps, weight: weight);
    return setEntryDto.toSetEntryEntity();
  }

  @override
  Future<void> deleteSetEntry({required int setEntryId}) {
    return _setEntryDataSource.deleteSetEntry(id: setEntryId);
  }

  @override
  Future<List<SetEntry>> getSetEntries({DateTime? startDate, DateTime? endDate}) async {
    final setEntries = await _setEntryDataSource.getSetEntries(startDate: startDate, endDate: endDate);
    return setEntries.map((e) => e.toSetEntryEntity()).toList();
  }

  @override
  Future<List<SetEntry>> getSetEntriesPerExercise(
      {required int exerciseId, DateTime? startDate, DateTime? endDate}) async {
    final setEntries =
        await _setEntryDataSource.getSetEntries(exerciseId: exerciseId, startDate: startDate, endDate: endDate);
    return setEntries.map((e) => e.toSetEntryEntity()).toList();
  }

  @override
  Future<SetEntry> updateSetEntry({required int setEntryId, double? weight, int? reps}) async {
    final setEntryDto = await _setEntryDataSource.updateSetEntry(id: setEntryId, reps: reps, weight: weight);
    return setEntryDto.toSetEntryEntity();
  }
}
