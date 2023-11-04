import 'package:flutter/material.dart';

class PlanCreationScreen extends StatelessWidget {
  const PlanCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Creation'),
      ),
      body: const Center(
        child: Text('This is the Plan Creation Screen'),
      ),
    );
  }
}
