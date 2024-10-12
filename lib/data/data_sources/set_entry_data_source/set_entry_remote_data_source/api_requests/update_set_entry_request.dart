import 'dart:convert';

import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class UpdateSetEntryRequest extends ClientRequest {
  UpdateSetEntryRequest({required int id, int? reps, double? weight})
      : super(
          method: HttpMethod.put,
          path: '/set-entry/$id',
          body: jsonEncode({
            if (reps != null) 'reps': reps.toString(),
            if (weight != null) 'weight': weight.toString(),
          }),
        );
}
