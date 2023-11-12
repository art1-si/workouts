import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GraphProperties { perWeight, oneRepMax, simpleVolumePerSet }
final graphSelector = ChangeNotifierProvider.autoDispose((ref) {
  return GraphSelectorProvider();
});

class GraphSelectorProvider extends ChangeNotifier {
  GraphProperties _properties = GraphProperties.oneRepMax;

  GraphProperties get graphProperties => _properties;

  String propertiesToString(GraphProperties _value) {
    switch (_value) {
      case GraphProperties.perWeight:
        return "Max weight";

      case GraphProperties.oneRepMax:
        return "Epley one rep max";

      case GraphProperties.simpleVolumePerSet:
        return "Volume per set";
    }
  }

  void setGraphProperties(GraphProperties newValue) {
    _properties = newValue;
    notifyListeners();
  }
}
