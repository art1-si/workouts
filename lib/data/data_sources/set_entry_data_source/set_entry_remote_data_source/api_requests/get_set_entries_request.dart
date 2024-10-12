import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

final class GetSetEntriesRequest extends ClientRequest {
  GetSetEntriesRequest({int? exerciseId, DateTime? startDate, DateTime? endDate})
      : super(
          method: HttpMethod.get,
          path: '/set-entry',
          parameters: {
            if (exerciseId != null) 'exerciseId': exerciseId.toString(),
            if (startDate != null) 'startDate': startDate.toIso8601String(),
            if (endDate != null) 'endDate': endDate.toIso8601String(),
          },
        );
}
