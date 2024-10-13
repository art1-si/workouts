import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class GetExercisesRequest extends ApiRequest {
  GetExercisesRequest() : super(method: HttpMethod.get, path: '/exercises');
}
