import 'package:workouts/data/dto_models/auth_token_dto.dart';

abstract interface class AuthenticationDataSource {
  /// Sign in with email and password.
  ///
  /// Returns [AuthTokenDto] if the sign in was successful.
  /// Throws AuthenticationException if the sign in was unsuccessful.
  Future<AuthTokenDto> signIn(String email, String password);

  /// Sign up with email and password.
  ///
  /// Returns [AuthTokenDto] if the sign up was successful.
  /// Throws AuthenticationException if the sign up was unsuccessful.
  Future<AuthTokenDto> signUp(String email, String password);

  /// Sign out.
  Future<void> signOut();

  /// Check if the user is authenticated.
  Future<bool> isAuthenticated();
}
