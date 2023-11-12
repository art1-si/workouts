// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PropertiesDropDown extends ConsumerWidget {
//   const PropertiesDropDown({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _selector = watch(graphSelector);

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 40,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: AppTheme.of(context).primary,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: DropdownButton<GraphProperties>(
//             icon: Icon(Icons.keyboard_arrow_down),
//             iconSize: 24,
//             elevation: 0,
//             alignment: AlignmentDirectional.topCenter,
//             underline: Container(),
//             isExpanded: true,
//             dropdownColor: AppTheme.of(context).primary,
//             value: _selector.graphProperties,
//             onChanged: (GraphProperties? newValue) {
//               context.read(graphSelector).setGraphProperties(newValue!);
//             },
//             items: GraphProperties.values.map((GraphProperties properties) {
//               return DropdownMenuItem<GraphProperties>(
//                 value: properties,
//                 child: Text(
//                   _selector.propertiesToString(properties),
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
