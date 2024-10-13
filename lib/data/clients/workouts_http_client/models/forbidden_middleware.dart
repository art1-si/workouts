import 'package:workouts/data/clients/workouts_http_client/models/client_request.dart';

class ForbiddenMiddleware<RefreshTokenResponseT> {
  ForbiddenMiddleware({
    required this.refreshTokenRequest,
    required this.shouldRetryInitialRequest,
    required this.refreshTokenResponseParser,
  });

  /// The request to refresh the token.
  final ApiRequest refreshTokenRequest;

  /// A function that determines whether the initial request should be retried after the token has been refreshed.
  /// The function should return `true` if the initial request should be retried, and `false` otherwise.
  final Future<bool> Function(Future<RefreshTokenResponseT> Function() response) shouldRetryInitialRequest;

  /// A function that parses the response from the refresh token request.
  final RefreshTokenResponseT Function(String) refreshTokenResponseParser;
}
