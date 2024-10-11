import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../lib/presentation/features/authentication/bloc/auth_state.dart';
import 'models/user_view_model.dart';
import '../../data/authentication/authentication_repository.dart';
import '../../data/authentication/firebase_auth_repository.dart';

final authControllerProvider = NotifierProvider<AuthenticationController, AuthenticationState>(() {
  return AuthenticationController(authenticationRepository: FirebaseAuthenticationRepository.instance);
});

class AuthenticationController extends Notifier<AuthenticationState> {
  AuthenticationController({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  AuthenticationState build() {
    return const AuthenticationLoading();
  }

  Future<void> signInWithCredentials({required String email, required String password}) async {
    state = const AuthenticationLoading();
    final user = await _authenticationRepository.signInWithCredentials(email: email, password: password);
    state = Authenticated(UserViewModel.fromUser(user));
  }

  Future<void> signOut() async {
    state = const AuthenticationLoading();
    await _authenticationRepository.signOut();
    state = const Unauthenticated();
  }

  Future<bool> isUserAuthenticated() async {
    final authenticatedUser = await _authenticationRepository.isSignedIn();
    if (authenticatedUser != null) {
      state = Authenticated(UserViewModel.fromUser(authenticatedUser));
      return true;
    }
    return false;
  }
}
