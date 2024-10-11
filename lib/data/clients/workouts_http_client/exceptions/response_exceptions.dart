class ResponseException implements Exception {
  const ResponseException({
    required this.requestUrl,
    required this.responseBody,
    required this.statusCode,
  });

  final String requestUrl;
  final String responseBody;
  final int statusCode;
}
