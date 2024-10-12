import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workouts/presentation/navigation/navigation_routes.dart';
import 'log_overview_card.dart';

class LogsListView extends StatelessWidget {
  const LogsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return workoutLogsAsyncList.when(
      data: (data) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: 4,
          ),
          itemBuilder: (context, index) {
            return SetEntryOverviewCard(
              title: data[index].exercise.exerciseName,
              setEntry: data[index].workoutLog,
              onTap: () => context.pushNamed(NavigationRoute.logCreation.named,
                  extra: {'exercises': data.map((e) => e.exercise).toList(), 'indexOfSelectedExercise': index}),
            );
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
