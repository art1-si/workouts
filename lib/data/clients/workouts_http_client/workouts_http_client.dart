import 'package:http/http.dart' as http;
import 'package:workouts/data/clients/workouts_http_client/exceptions/network_client_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/exceptions/response_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';
import 'package:workouts/data/clients/workouts_http_client/models/forbidden_middleware.dart';
import 'package:workouts/data/clients/workouts_http_client/request_constructor.dart';
import 'package:workouts/dev_tools/logger/logger.dart';

class WorkoutsHttpClient {
  WorkoutsHttpClient({
    http.Client? httpClient,
    RequestConstructor? requestConstructor,
    this.forbiddenMiddleware,
  })  : _requestConstructor = requestConstructor ?? RequestConstructor(),
        _client = httpClient ?? http.Client();

  final http.Client _client;
  final RequestConstructor _requestConstructor;

  /// It's a callback that will be called when the server returns a 403 status code.
  /// It should return a [ForbiddenMiddleware] object that contains the refresh token request,
  /// a function that determines whether the initial request should be retried after the token has been refreshed,
  /// and a function that parses the response from the refresh token request.
  ///
  /// If this callback is not provided, the client will not attempt to refresh the token.
  /// And if the server returns a 403 status code, the client will throw a [ResponseException].
  final Future<ForbiddenMiddleware?> Function()? forbiddenMiddleware;

  Future<ParsedResponseT> executeRequest<ParsedResponseT>({
    required ApiRequest request,
    required ParsedResponseT Function(String responseBody) parser,
  }) async {
    Logger.info('Executing request: ${request.method} ${request.path}');

    final response = await _forbiddenHandlerWrapper(() async {
      final httpRequest = await _requestConstructor.constructRequest(request: request);

      return _sendRequest(httpRequest);
    });

    if (response.statusCode <= 200 && response.statusCode < 300) {
      return _parseResponse(response: response, parser: parser);
    }

    throw ResponseException(
      requestUrl: response.request?.url.toString() ?? request.path,
      responseBody: response.body,
      statusCode: response.statusCode,
    );
  }

  Future<http.Response> _sendRequest(http.Request request) async {
    final response = await _client.send(request).timeout(const Duration(seconds: 10), onTimeout: () {
      throw const ClientTimeOutException();
    });

    return http.Response.fromStream(response);
  }

  Future<http.Response> _forbiddenHandlerWrapper(
    Future<http.Response> Function() requestExecutor,
  ) async {
    final response = await requestExecutor();
    if (response.statusCode != 403 || forbiddenMiddleware == null) {
      return response;
    }

    final middleware = await forbiddenMiddleware!();
    if (middleware == null) {
      return response;
    }

    final refreshRequest = await _requestConstructor.constructRequest(request: middleware.refreshTokenRequest);
    final shouldRetryInitialRequest = await middleware.shouldRetryInitialRequest(() async {
      final refreshResponse = await _sendRequest(refreshRequest);

      if (refreshResponse.statusCode == 200) {
        return middleware.refreshTokenResponseParser(refreshResponse.body);
      }

      throw ResponseException(
        requestUrl: refreshResponse.request?.url.toString() ?? middleware.refreshTokenRequest.path,
        responseBody: refreshResponse.body,
        statusCode: refreshResponse.statusCode,
      );
    });

    if (shouldRetryInitialRequest) {
      return requestExecutor();
    }

    return response;
  }

  ParsedResponseT _parseResponse<ParsedResponseT>({
    required http.Response response,
    required ParsedResponseT Function(String responseBody) parser,
  }) {
    try {
      return parser(response.body);
    } catch (error) {
      throw ResponseParseException(
        responseBody: response.body,
        statusCode: response.statusCode,
        requestUrl: response.request!.url.toString(),
        error: error,
      );
    }
  }
}
