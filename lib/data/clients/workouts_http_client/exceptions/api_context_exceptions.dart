abstract base class ApiContextException implements Exception {
  const ApiContextException();

  @override
  String toString() {
    return 'NetworkException: $runtimeType';
  }
}

final class UninitiatedApiContextException extends ApiContextException {
  const UninitiatedApiContextException();

  @override
  String toString() {
    return 'UninitiatedApiContextException: Make sure to call load(), or create() before your first request.';
  }
}

final class BaseUrlNotFoundException extends ApiContextException {
  const BaseUrlNotFoundException();

  @override
  String toString() {
    return 'BaseUrlNotFoundException: The base URL was not found in the storage.';
  }
}
