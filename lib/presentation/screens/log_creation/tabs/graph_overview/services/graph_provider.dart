import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chartProvider = ChangeNotifierProvider.autoDispose<GraphProvider>((ref) {
  return GraphProvider();
});

//?Is responsible for changing color of graph when pressed
class GraphProvider extends ChangeNotifier {
  bool _graphIsPressed = false;
  bool get showSelector => _graphIsPressed;
  void handleGraphPressed() {
    _graphIsPressed ? _graphIsPressed = false : _graphIsPressed = true;
    notifyListeners();
  }
}
