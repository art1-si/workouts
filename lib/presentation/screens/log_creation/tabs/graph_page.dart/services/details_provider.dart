// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';
// import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_selector_provider.dart';
// import 'package:workout_notes_app/services/1rm_formula.dart';

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

//   GraphModel? get logDetails => _log ?? points!.last;
//   int? get index => _index;
//   Offset? get offset => _offset;

//   void setOffset(Offset? offset) {
//     _offset = offset;
//     _comperOffset();
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
//         _value = epleyCalOneRepMax(logDetails!.corespondingLog.weight,
//             logDetails!.corespondingLog.reps);
//         break;
//       case GraphProperties.simpleVolumePerSet:
//         _value = logDetails!.corespondingLog.weight *
//             logDetails!.corespondingLog.reps;
//         break;
//     }
//     return _value;
//   }

//   void _comperOffset() {
//     if (_offset != null) {
//       double distance = points!.first.nextX - points!.first.x;
//       double halfDistance = (points!.first.nextX - points!.first.x) / 2;
//       for (var i = 0; i < points!.length; i++) {
//         var point = points![i];
//         if (_offset!.dx + halfDistance < (point.x + distance) &&
//             _offset!.dx + halfDistance >= point.x) {
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
