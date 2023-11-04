import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workouts/presentation/navigation/router.dart';
import 'package:workouts/presentation/navigation/screens.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      AppRouter.router.goNamed(Screens.logsOverview.key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
