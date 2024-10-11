abstract interface class AuthenticationRepository {
  /// Returns the current user's authentication status.
  Future<bool> isAuthenticated();

  /// Signs in the user with the provided [email] and [password].
  Future<void> signIn({required String email, required String password});

  /// Registers a new user with the provided [email] and [password].
  Future<void> signUp({required String email, required String password});

  /// Signs out the current user.
  Future<void> signOut();
}
