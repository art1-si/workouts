import 'package:workouts/data/data_sources/authentication_data_source/authentication_data_source.dart';
import 'package:workouts/domain/repositories/authentication_repository.dart';

class AuthenticationDataRepository implements AuthenticationRepository {
  AuthenticationDataRepository({required this.authenticationDataSource});

  final AuthenticationDataSource authenticationDataSource;

  @override
  Future<bool> isAuthenticated() {
    return authenticationDataSource.isAuthenticated();
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return authenticationDataSource.signIn(email, password);
  }

  @override
  Future<void> signOut() {
    return authenticationDataSource.signOut();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return authenticationDataSource.signUp(email, password);
  }
}
