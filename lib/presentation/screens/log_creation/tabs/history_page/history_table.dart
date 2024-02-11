import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workouts/data/workout_logs/models/workout_log.dart';
import 'package:workouts/global/extensions/date_time.dart';
import 'package:workouts/presentation/screens/logs_overview/widgets/log_overview_card.dart';
import 'package:workouts/presentation/theme/app_colors.dart';

class HistoryTable extends StatelessWidget {
  const HistoryTable({
    Key? key,
    required this.model,
  }) : super(key: key);
  final List<WorkoutLog> model;
  @override
  Widget build(BuildContext context) {
    final groupedEntries = groupBy(model, (WorkoutLog entry) => entry.dateCreated.atNoon);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
          height: 4,
        ),
        itemCount: groupedEntries.length,
        itemBuilder: (context, i) {
          final date = groupedEntries.keys.elementAt(i);
          return _Animator(
            index: i,
            child: LogOverviewCard(
              title: date.toPMTViewFormat(),
              workoutLog: groupedEntries[date]!,
              backgroundColor: AppColors.primaryShades.shade100,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class _Animator extends StatefulWidget {
  const _Animator({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);
  final Widget child;
  final int index;
  @override
  __AnimatorState createState() => __AnimatorState();
}

class __AnimatorState extends State<_Animator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));
  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 0.1,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInExpo,
  ));
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 0.9,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));
  int get _duration => widget.index * 100;
  late final Timer _timer;
  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: _duration), () async {
      await _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _offsetAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
