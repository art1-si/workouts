import 'package:flutter/material.dart';

class ExerciseCreationScreen extends StatelessWidget {
  const ExerciseCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Creation'),
      ),
      body: Center(
        child: Text('This is the Exercise Creation Screen'),
      ),
    );
  }
}
