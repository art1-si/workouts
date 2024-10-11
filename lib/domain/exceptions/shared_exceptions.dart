/// Generic exception.
/// This exception is thrown when app couldn't identify error,
/// because it couldn't find origin, or something unexpected happened.
class GenericException implements Exception {
  GenericException(this.error);

  Object error;
}

/// Exception thrown when user is most likely offline.
class NoInternetException implements Exception {
  NoInternetException();
}
