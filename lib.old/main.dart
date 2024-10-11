import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/configuration/firebase/firebase_options.dart';
import 'data/authentication/firebase_auth_repository.dart';
import 'injection_providers.dart';
import '../lib/presentation/workouts_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instanceFor(app: app);

  FirebaseAuthenticationRepository.instance.init(auth);

  final sharedPref = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(sharedPref),
      ],
      child: const WorkoutsApp(),
    ),
  );
}
