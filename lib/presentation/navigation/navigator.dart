import 'package:flutter/material.dart';

class StateNavigator extends StatefulWidget {
  const StateNavigator({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  _StateNavigatorState createState() => _StateNavigatorState();
}

class _StateNavigatorState extends State<StateNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
