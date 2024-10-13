import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class RefreshTokenRequest extends ApiRequest {
  RefreshTokenRequest({required String refreshToken})
      : super(
          method: HttpMethod.post,
          path: '/refreshToken',
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        );
}
