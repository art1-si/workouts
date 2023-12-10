// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/services/graph_selector_provider.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/rep_max_view.dart';

// final detailsProvider = ChangeNotifierProvider.autoDispose(
//   (ref) {
//     final _property = ref.watch(graphSelector).graphProperties;
//     return DetailsProvider(_property);
//   },
// );

// class DetailsProvider extends ChangeNotifier {
//   DetailsProvider(this.properties);

//   final GraphProperties properties;
//   GraphModel? _log;
//   Offset? _offset;
//   int? _index;
//   List<GraphModel>? points;

//   //double? width;

//   GraphModel? get logDetails => _log ?? points?.lastOrNull;
//   int? get index => _index;
//   Offset? get offset => _offset;

//   void setOffset(Offset? offset) {
//     _offset = offset;
//     _compereOffset();
//   }

//   void _setDetails(GraphModel? value) {
//     _log = value;
//     notifyListeners();
//   }

//   double? pointedValue() {
//     double? _value;
//     switch (properties) {
//       case GraphProperties.perWeight:
//         break;
//       case GraphProperties.oneRepMax:
//         _value = epleyCalOneRepMax(logDetails!.correspondingLog.weight, logDetails!.correspondingLog.reps);
//         break;
//       case GraphProperties.simpleVolumePerSet:
//         _value = logDetails!.correspondingLog.weight * logDetails!.correspondingLog.reps;
//         break;
//     }
//     return _value;
//   }

//   void _compereOffset() {
//     if (_offset != null) {
//       var distance = points!.first.nextX - points!.first.x;
//       var halfDistance = (points!.first.nextX - points!.first.x) / 2;
//       for (var i = 0; i < points!.length; i++) {
//         var point = points![i];
//         if (_offset!.dx + halfDistance < (point.x + distance) && _offset!.dx + halfDistance >= point.x) {
//           _index = i;
//           if (_log != point) {
//             _setDetails(point);
//           }
//         }
//       }
//     } else {
//       _setDetails(null);
//       _index = null;
//     }
//   }
// }
