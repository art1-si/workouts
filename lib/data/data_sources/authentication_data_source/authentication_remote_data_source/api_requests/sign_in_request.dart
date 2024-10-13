import 'dart:convert';

import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class SignInRequest extends ApiRequest {
  SignInRequest({required String email, required String password})
      : super(
          method: HttpMethod.post,
          path: '/login',
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );
}
