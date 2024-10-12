import 'dart:convert';

import 'package:workouts/data/dto_models/set_entry_dto.dart';
import 'package:workouts/data/data_sources/remote_data_source.dart';
import 'package:workouts/data/data_sources/set_entry_data_source/set_entry_data_source.dart';
import 'package:workouts/data/data_sources/set_entry_data_source/set_entry_remote_data_source/api_requests/create_set_entry_request.dart';
import 'package:workouts/data/data_sources/set_entry_data_source/set_entry_remote_data_source/api_requests/get_set_entries_request.dart';
import 'package:workouts/data/data_sources/set_entry_data_source/set_entry_remote_data_source/api_requests/update_set_entry_request.dart';

final class SetEntryRemoteDataSource extends RemoteDataSource implements SetEntryDataSource {
  SetEntryRemoteDataSource({required super.httpClient});

  @override
  Future<SetEntryDto> addSetEntry({required int exerciseId, required int reps, required double weight}) async {
    final request = CreateSetEntryRequest(exerciseId: exerciseId, reps: reps, weight: weight);
    final response = await httpClient.executeRequest(request: request, parser: SetEntryDto.fromJson);

    return response;
  }

  @override
  Future<void> deleteSetEntry({required int id}) {
    // TODO: implement deleteSetEntry
    throw UnimplementedError();
  }

  @override
  Future<List<SetEntryDto>> getSetEntries({int? exerciseId, DateTime? startDate, DateTime? endDate}) async {
    final request = GetSetEntriesRequest(exerciseId: exerciseId, startDate: startDate, endDate: endDate);
    final response = await httpClient.executeRequest(
        request: request,
        parser: (responseBody) {
          final decoded = json.decode(responseBody) as List;
          return decoded.map((e) => SetEntryDto.fromMap(e)).toList();
        });
    return response;
  }

  @override
  Future<SetEntryDto> updateSetEntry({required int id, int? reps, double? weight}) async {
    final request = UpdateSetEntryRequest(id: id, reps: reps, weight: weight);
    final response = await httpClient.executeRequest(request: request, parser: SetEntryDto.fromJson);

    return response;
  }
}
