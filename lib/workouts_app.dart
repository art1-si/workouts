import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/navigation/router.dart';

class WorkoutsApp extends StatelessWidget {
  const WorkoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
