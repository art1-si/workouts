import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workouts/configuration/firebase/firebase_options.dart';
import 'package:workouts/data/authentication/firebase_auth_repository.dart';
import 'package:workouts/workouts_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instanceFor(app: app);

  FirebaseAuthenticationRepository.instance.init(auth);

  runApp(
    const WorkoutsApp(),
  );
}
