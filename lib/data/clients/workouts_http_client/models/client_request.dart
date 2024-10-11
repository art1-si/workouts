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
  /// The HTTP method for the endpoint.
  HttpMethod get method;

  /// The path for the endpoint.
  String get path;

  /// The request body for the endpoint.
  String? get body => null;

  /// The request headers for the endpoint.
  Map<String, String>? get headers => null;

  /// The request query parameters for the endpoint.
  Map<String, String>? get parameters => null;

  /// The request timeout for the endpoint.
  Duration get timeout => const Duration(seconds: 30);
}
