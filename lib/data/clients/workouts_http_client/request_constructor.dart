import 'package:http/http.dart' as http;
import 'package:workouts/data/clients/workouts_http_client/api_context.dart';
import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

class RequestConstructor {
  Future<http.Request> constructRequest({
    required ApiRequest request,
  }) async {
    final uri = await _constructUri(request);
    final draftRequest = http.Request(request.method.key, uri);

    draftRequest.headers['Content-Type'] = 'application/json; charset=utf-8';
    draftRequest.headers['Accept-Charset'] = 'utf-8';

    if (request.headers != null) {
      draftRequest.headers.addAll(request.headers!);
    }

    if (request.body != null) {
      draftRequest.body = request.body!;
    }

    return draftRequest;
  }

  Future<Uri> _constructUri(ApiRequest request) async {
    final apiContext = ApiContext.instance;

    final _host = apiContext.host;
    final pathPrefix = apiContext.pathPrefix;
    return Uri(
      scheme: 'https',
      host: _host,
      path: '${pathPrefix ?? ''}${request.path}',
      queryParameters: request.parameters,
    );
  }
}
