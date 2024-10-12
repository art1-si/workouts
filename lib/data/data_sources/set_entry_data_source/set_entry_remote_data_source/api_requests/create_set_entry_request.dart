import 'dart:convert';

import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class CreateSetEntryRequest extends ClientRequest {
  CreateSetEntryRequest({required int exerciseId, required int reps, required double weight})
      : super(
          method: HttpMethod.post,
          path: '/set-entry',
          body: jsonEncode({
            'exerciseId': exerciseId,
            'reps': reps,
            'weight': weight,
          }),
        );
}
