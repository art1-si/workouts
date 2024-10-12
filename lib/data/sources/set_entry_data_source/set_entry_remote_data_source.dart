import 'package:workouts/data/dto_models/set_entry_dto.dart';
import 'package:workouts/data/sources/remote_data_source.dart';
import 'package:workouts/data/sources/set_entry_data_source/set_entry_data_source.dart';

final class SetEntryRemoteDataSource extends RemoteDataSource implements SetEntryDataSource {
  SetEntryRemoteDataSource({required super.httpClient});

  @override
  Future<SetEntryDto> addSetEntry({required int exerciseId, required int reps, required double weight}) {
    // TODO: implement addSetEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSetEntry({required int id}) {
    // TODO: implement deleteSetEntry
    throw UnimplementedError();
  }

  @override
  Future<List<SetEntryDto>> getSetEntries({int? exerciseId, DateTime? startDate, DateTime? endDate}) {
    // TODO: implement getSetEntries
    throw UnimplementedError();
  }

  @override
  Future<SetEntryDto> updateSetEntry({required int id, int? reps, double? weight}) {
    // TODO: implement updateSetEntry
    throw UnimplementedError();
  }
}
