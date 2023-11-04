import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workouts/configuration/firebase/firebase_options.dart';
import 'package:workouts/workouts_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const WorkoutsApp(),
  );
}
