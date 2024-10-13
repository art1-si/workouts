abstract base class NetworkClientException implements Exception {
  const NetworkClientException();

  @override
  String toString() {
    return 'NetworkException: $runtimeType';
  }
}

final class ClientTimeOutException extends NetworkClientException {
  const ClientTimeOutException();

  @override
  String toString() {
    return 'ClientTimeOutException: The client timed out.';
  }
}

final class ResponseParseException extends NetworkClientException {
  const ResponseParseException({
    required this.responseBody,
    required this.statusCode,
    required this.requestUrl,
    required this.error,
  });

  final String responseBody;
  final int statusCode;
  final String requestUrl;
  final Object error;

  @override
  String toString() {
    return 'ResponseParseException: The response could not be parsed.\nError: $error';
  }
}

final class NoRefreshTokenException extends NetworkClientException {
  const NoRefreshTokenException();

  @override
  String toString() {
    return 'NoRefreshTokenException: No refresh token found. Failed to refresh access token.';
  }
}
