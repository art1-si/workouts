import 'dart:convert';

import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class SignUpRequest extends ApiRequest {
  SignUpRequest({required String email, required String password})
      : super(
          method: HttpMethod.post,
          path: '/register',
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );
}
