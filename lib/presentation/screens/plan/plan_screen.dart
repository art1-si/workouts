import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Screen'),
      ),
      body: Center(
        child: Text('This is the Plan Screen'),
      ),
    );
  }
}
