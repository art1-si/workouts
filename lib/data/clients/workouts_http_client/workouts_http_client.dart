import 'package:http/http.dart' as http;
import 'package:workouts/data/clients/workouts_http_client/exceptions/network_client_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/exceptions/response_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';
import 'package:workouts/data/clients/workouts_http_client/request_constructor.dart';
import 'package:workouts/dev_tools/logger/logger.dart';

class WorkoutsHttpClient {
  WorkoutsHttpClient({http.Client? httpClient, RequestConstructor? requestConstructor})
      : _requestConstructor = requestConstructor ?? RequestConstructor(),
        _client = httpClient ?? http.Client();

  final http.Client _client;
  final RequestConstructor _requestConstructor;

  Future<ParsedResponseT> executeRequest<ParsedResponseT>({
    required ClientRequest request,
    required ParsedResponseT Function(String responseBody) parser,
  }) async {
    Logger.info('Executing request: ${request.method} ${request.path}');
    final httpRequest = await _requestConstructor.constructRequest(request: request);

    final responseStreamed = await _client.send(httpRequest).timeout(request.timeout, onTimeout: () {
      throw const ClientTimeOutException();
    });

    final response = await http.Response.fromStream(responseStreamed);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ResponseException(
        requestUrl: httpRequest.url.toString(),
        responseBody: response.body,
        statusCode: response.statusCode,
      );
    }
    try {
      return parser(response.body);
    } catch (error) {
      throw ResponseParseException(
        responseBody: response.body,
        statusCode: response.statusCode,
        requestUrl: httpRequest.url.toString(),
        error: error,
      );
    }
  }
}
