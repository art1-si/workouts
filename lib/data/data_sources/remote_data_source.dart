import 'package:workouts/data/clients/workouts_http_client/workouts_http_client.dart';

abstract base class RemoteDataSource {
  const RemoteDataSource({
    required this.httpClient,
  });
  final WorkoutsHttpClient httpClient;
}
