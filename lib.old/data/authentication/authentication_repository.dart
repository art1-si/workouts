import '../../../lib/domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  /// Checks if the user is currently authenticated.
  Future<User?> isSignedIn();

  /// Signs in with the provided [email] and [password].
  Future<User> signInWithCredentials({required String email, required String password});

  /// Creates a new user with the provided [email] and [password].
  Future<User> signUp({required String email, required String password});

  /// Signs out the current user.
  Future<void> signOut();
}
