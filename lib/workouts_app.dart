import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/presentation/navigation/navigator.dart';
import 'package:workouts/presentation/navigation/router.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class WorkoutsApp extends StatelessWidget {
  const WorkoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenNavigator(
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryShades.shade100,
          ),
        ),
      ),
    );
  }
}
