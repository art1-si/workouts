import 'package:flutter/material.dart';
import 'package:workouts/dependency_locator.dart';
import 'package:workouts/presentation/workouts_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerDependencies();

  runApp(
    const WorkoutsApp(),
  );
}
