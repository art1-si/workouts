import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/application/authentication/models/auth_state.dart';
import 'package:workouts/presentation/navigation/router.dart';
import 'package:workouts/presentation/navigation/screens.dart';

class ScreenNavigator extends ConsumerStatefulWidget {
  const ScreenNavigator({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends ConsumerState<ScreenNavigator> {
  @override
  void initState() {
    super.initState();
    ref.read(authControllerProvider.notifier).isUserAuthenticated()
      ..then((value) {
        if (!value) {
          AppRouter.router.goNamed(Screens.login.key);
        } else {
          AppRouter.router.goNamed(Screens.logsOverview.key);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next is Unauthenticated && previous is Authenticated) {
        AppRouter.router.goNamed(Screens.login.key);
      }
      if (next is Authenticated && !(previous is Authenticated)) {
        AppRouter.router.goNamed(Screens.logsOverview.key);
      }
    });
    return widget.child;
  }
}
