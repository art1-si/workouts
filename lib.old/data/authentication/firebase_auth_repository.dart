import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'authentication_repository.dart';
import '../../../lib/domain/entities/user.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  FirebaseAuthenticationRepository._();
  late final fa.FirebaseAuth _firebaseAuth;

  static FirebaseAuthenticationRepository instance = FirebaseAuthenticationRepository._();

  void init(fa.FirebaseAuth instance) {
    _firebaseAuth = instance;
  }

  @override
  Future<User> signInWithCredentials({required String email, required String password}) async {
    final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return User(id: firebaseUser.user!.uid);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User> signUp({required String email, required String password}) async {
    final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return User(id: firebaseUser.user!.uid);
  }

  @override
  Future<User?> isSignedIn() async {
    return _firebaseAuth.currentUser == null ? null : User(id: _firebaseAuth.currentUser!.uid);
  }
}
