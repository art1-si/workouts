import 'package:flutter/material.dart';

class LogCreationScreen extends StatelessWidget {
  const LogCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Creation'),
      ),
      body: const Center(
        child: Text('This is the Log Creation Screen'),
      ),
    );
  }
}
