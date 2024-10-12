enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  const HttpMethod(this.key);
  final String key;
}

/// Abstract base class for client requests.
abstract base class ClientRequest {
  const ClientRequest({
    required this.method,
    required this.path,
    this.body,
    this.headers,
    this.parameters,
    this.timeout = const Duration(seconds: 30),
  });

  /// The HTTP method for the endpoint.
  final HttpMethod method;

  /// The path for the endpoint.
  final String path;

  /// The request body for the endpoint.
  final String? body;

  /// The request headers for the endpoint.
  final Map<String, String>? headers;

  /// The request query parameters for the endpoint.
  final Map<String, String>? parameters;

  /// The request timeout for the endpoint.
  final Duration timeout;
}
