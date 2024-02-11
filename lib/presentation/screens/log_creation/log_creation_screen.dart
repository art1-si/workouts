import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/selected_date/selected_date_controller.dart';
import 'package:workouts/application/workout_logs/models/workout_log_view_model.dart';
import 'package:workouts/application/workout_logs/workout_logs_for_exercise_notifier.dart';
import 'package:workouts/data/exercises/model/exercise.dart';
import 'package:workouts/presentation/screens/log_creation/exercise_log_view_controller.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/create_entry/log_screen.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/graph_overview/graph_overview_tab.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/history_page/history_view.dart';
import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class LogCreationScreen extends ConsumerWidget {
  LogCreationScreen({super.key, required List<Exercise> exercises, required int indexOfSelectedExercise})
      : viewController = WorkoutLogViewController(exercises, indexOfSelectedExercise);

  final WorkoutLogViewController viewController;

  Widget _body({
    required WorkoutLogViewModel exerciseLog,
    required BuildContext context,
    required DateTime selectedDate,
  }) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        LogScreen(
          exerciseLog: exerciseLog,
          selectedDate: selectedDate,
        ),
        GraphOverviewTab(
          workoutLogs: exerciseLog.workoutLog,
        ),
        HistoryView(
          exerciseLog: exerciseLog.workoutLog,
        ),
        RepMaxView(
          exerciseLog: exerciseLog,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
        listenable: viewController,
        builder: (context, child) {
          final logsForSelectedExercise = ref.watch(workoutLogsForExerciseProvider(viewController.value));
          return DefaultTabController(
            length: 4,
            child: GestureDetector(
              onTap: () {
                final currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                color: AppColors.primaryShades.shade100,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: AppColors.primaryShades.shade110,
                    appBar: AppBar(
                      actions: [
                        IconButton(
                          onPressed: viewController.canGoToPrevious ? viewController.goToPrevious : null,
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: viewController.canGoToPrevious ? Colors.white : Colors.white30,
                            ),
                          ),
                        ),
                        IconButton(
                          enableFeedback: true,
                          onPressed: viewController.canGoToNext ? viewController.goToNext : null,
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: viewController.canGoToNext ? Colors.white : Colors.white30,
                            ),
                          ),
                        ),
                      ],
                      backgroundColor: AppColors.primaryShades.shade100,
                      elevation: 0,
                      centerTitle: true,
                      title: StyledText.labelMedium(
                        viewController.value.exerciseName,
                        //style: Theme.of(context).textTheme.headline4,
                      ),
                      bottom: const _TabBars(),
                    ),
                    body: logsForSelectedExercise.when(
                      data: (exerciseLog) {
                        return _body(
                          context: context,
                          exerciseLog: exerciseLog,
                          selectedDate: ref.read(selectedDateProvider),
                        );
                      },
                      //TODO(Artur):Create shimmer effect
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },

                      //TODO(Artur):better error handling
                      error: (error, __) => const Center(
                        child: Text('Something went wrong\nerror'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _TabBars extends StatelessWidget implements PreferredSizeWidget {
  const _TabBars();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      dividerHeight: 0,
      indicatorWeight: 0.1,
      indicatorColor: Colors.transparent,
      labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, overflow: TextOverflow.fade),
      labelColor: Colors.white,
      unselectedLabelStyle: TextStyle(fontSize: 14, overflow: TextOverflow.fade),
      tabs: <Widget>[
        SizedBox(
          height: 35,
          child: Center(child: Text('LOG', overflow: TextOverflow.ellipsis)),
        ),
        SizedBox(
          height: 35,
          child: Center(child: Text('GRAPH', overflow: TextOverflow.ellipsis)),
        ),
        SizedBox(
          height: 35,
          child: Center(child: Text('HISTORY', overflow: TextOverflow.ellipsis)),
        ),
        SizedBox(
          height: 35,
          child: Center(child: Text('%RM', overflow: TextOverflow.ellipsis)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
