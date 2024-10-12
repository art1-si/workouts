import 'dart:convert';

import 'package:workouts/data/dto_models/exercise_dto.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_data_source.dart';
import 'package:workouts/data/sources/exercise_data_source/exercise_remote_data_source/api_requests/get_exercises_request.dart';
import 'package:workouts/data/sources/remote_data_source.dart';

final class ExerciseRemoteDataSource extends RemoteDataSource implements ExerciseDataSource {
  ExerciseRemoteDataSource({
    required super.httpClient,
  });

  @override
  Future<List<ExerciseDto>> getExercises() async {
    final request = GetExercisesRequest();
    final response = await httpClient.executeRequest(
        request: request,
        parser: (responseBody) {
          final decoded = json.decode(responseBody) as List;
          return decoded.map((e) => ExerciseDto.fromMap(e)).toList();
        });

    return response;
  }
}
