import 'package:workouts/domain/entities/user.dart';

sealed class AuthenticationState {
  const AuthenticationState();

  Authenticated get asAuthenticated => this as Authenticated;
}

class Authenticated extends AuthenticationState {
  const Authenticated(this.user);
  final User user;
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
