import 'package:workouts/application/authentication/models/user_view_model.dart';

sealed class AuthenticationState {
  const AuthenticationState();

  Authenticated get asAuthenticated => this as Authenticated;
}

class Authenticated extends AuthenticationState {
  final UserViewModel user;

  const Authenticated(this.user);
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
